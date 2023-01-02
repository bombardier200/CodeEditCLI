//
//  Version.swift
//  CodeEditCLI
//
//  Created by Lukas Pistrol on 06.12.22.
//

import ArgumentParser
import Foundation

extension CodeEditCLI {
    struct Version: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "version",
            abstract: "Prints the version of the CLI and CodeEdit.app."
        )

        func run() throws {
            // Print the cli version
            print("CodeEditCLI: \t\(CLI_VERSION)")

            // File URL of CodeEdit.app
            let appURL = URL(fileURLWithPath: "/Applications/CodeEdit.app")

            // Check if there is an Info.plist inside CodeEdit.app
            // Then get the version number and print it out
            //
            // This will fail when CodeEdit.app is not installed
            if let url = infoPlistUrl(appURL),
               let plist = NSDictionary(contentsOf: url) as? [String: Any],
               let version = plist["CFBundleShortVersionString"] as? String {
                print("CodeEdit.app: \t\(version)")
            } else {
                print("CodeEdit.app is not installed.")
            }
        }

        private func infoPlistUrl(_ url: URL?) -> URL? {
            if let url = url?.appendingPathComponent("Contents")
                             .appendingPathComponent("Info.plist") {
                return url
            } else {
                return nil
            }
        }
    }
}
