import SwiftUI
import UIKit
import MessageUI

/// Code's from [https://stackoverflow.com/questions/56784722/swiftui-send-email]

struct MailView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?

    @State var mainFormat = """
<h3>I'm really happy to get feedback!</h3>
<div>
What's your point?:
</div>
"""

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let viewContoller = MFMailComposeViewController()
        
        /// @Set email format
        viewContoller.setToRecipients(["aksidion@kreimben.com"])
        viewContoller.setSubject("T!mer - Feedback from \"your name\"")
        viewContoller.setMessageBody(mainFormat, isHTML: true)
        /// @END
        
        viewContoller.mailComposeDelegate = context.coordinator
        return viewContoller
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {

    }
}

//
//  MailView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 4/30/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
