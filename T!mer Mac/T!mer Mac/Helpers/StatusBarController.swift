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
        statusBarButton.sendAction(on: [.leftMouseDown, .rightMouseDown])
        statusBarButton.target = self
        
        /// Set Event Monitor
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown], handler: mouseEventHandler)
    }
    
    @objc func togglePopover(sender: AnyObject) {
        
        if(StatusBarController.popover.isShown) {
            
            hidePopover(sender)
        }
        else {
            
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject) {
        
        StatusBarController.popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
//        eventMonitor?.start()
    }
    
    func hidePopover(_ sender: AnyObject) {
        
        StatusBarController.popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    // MARK: - Mouse Event Handler
    func mouseEventHandler(_ event: NSEvent?) {
        
        if(StatusBarController.popover.isShown) {
            
            hidePopover(event!)
        }
    }
}
