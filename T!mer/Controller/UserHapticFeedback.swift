import Foundation
import SwiftUI
import CoreHaptics

class UserHapticFeedback {

    var engine: CHHapticEngine?

    lazy var intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
    lazy var sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)


    var player: CHHapticPatternPlayer?


    init() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {

            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {

            print("There was an error creating the engine: \(error.localizedDescription)")
        }

        engine?.stoppedHandler = { reason in
            print("The engine stopped: \(reason)")
        }

        engine?.resetHandler = { [weak self] in
            print("The engine reset")

            do {
                try self?.engine?.start()
            } catch {
                print("Failed to restart the engine: \(error)")
            }
        }

        //MARK:- Converting func hapticFeedbackWhenUserRotatesDial to init()

        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [self.intensity, self.sharpness], relativeTime: 0)

        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            self.player = try engine?.makePlayer(with: pattern)

            print("Ready for haptic feedback!")
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }

    func hapticFeedbackWhenUserRotatesDial() {

        do {
            try player?.start(atTime: 0)
            print("Fire haptic feedback!")
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}
