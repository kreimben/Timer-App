import AppKit
import SwiftUI
import UserNotifications

class StatusBarController: ObservableObject {
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    static var popover = NSPopover()
    @Published var statusBarButton: NSStatusBarButton
    private var eventMonitor: EventMonitor?
    
    let mainController = MainController()
    
    init() {
        
        statusBar = NSStatusBar.init()
        statusItem = statusBar.statusItem(withLength: 70.0)
        statusBarButton = statusItem.button!
        
        statusBarButton.image = NSImage(named: NSImage.Name("AppIcon"))
        statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
        statusBarButton.imagePosition = .imageRight
        statusBarButton.title = "T!mer"
        
        statusBarButton.action = #selector(togglePopover(sender:))
        statusBarButton.target = self
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown], handler: mouseEventHandler)
    }
    
    @objc func togglePopover(sender: AnyObject) {
        
        switch (NSApp.currentEvent!.type) {
        case .leftMouseUp:
            if(StatusBarController.popover.isShown) {

            hidePopover(sender)
            }
            else {

            showPopover(sender)
            }
            
        default:
            
            let quitAlert = NSAlert()
            quitAlert.messageText = "Quit"
            quitAlert.informativeText = "Do you want to quit this app?"

            quitAlert.addButton(withTitle: "Quit")
            quitAlert.buttons[0].target = self
            quitAlert.buttons[0].action = #selector(quitApp)

            quitAlert.addButton(withTitle: "Cancel")
            quitAlert.buttons[1].target = self

            quitAlert.showsSuppressionButton = true

            quitAlert.runModal()
        }
    }
    
    func showPopover(_ sender: AnyObject) {
        
        StatusBarController.popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
        eventMonitor?.start()
    }
    
    func hidePopover(_ sender: AnyObject) {
        
        StatusBarController.popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func mouseEventHandler(_ event: NSEvent?) {
        
        if(StatusBarController.popover.isShown) {
            
            hidePopover(event!)
        }
    }
    
    @objc func quitApp() {
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("All of pending notification requests is removed while app is quitted.")
        NSApplication.shared.terminate(self)
    }
}
