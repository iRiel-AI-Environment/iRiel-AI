OpenIRielIntent — Native Integration with the Apple Ecosystem

Project: iRiel AI — PRSL-AI Ecosystem
Framework: Apple App Intents
Platform: Native iOS
Status: Proposed — not yet integrated or compiled

1. Objective

OpenIRielIntent is the first proposed native intent for iRiel AI. Its purpose is to allow supported Apple system integrations, including Siri and Shortcuts, to request that the official iRiel application be opened.

The intent has a deliberately limited scope: requesting that the application open, without assuming responsibilities belonging to the iRiel Intelligence Engine.

2. Responsibilities

The intent must:

* Declare an action recognizable by the AppIntents framework.
* Request that the iRiel application open.
* Provide a predefined shortcut through AppShortcutsProvider.

The intent must not:

* Authenticate the user or initiate sessions.
* Create, manage, or resume conversations.
* Read from or modify memory.
* Execute external tools.
* Directly invoke iRiel Core or the Intelligence Engine.
* Implement orchestration or intelligence-processing logic.

3. Proposed Swift Implementation

OpenIRielIntent.swift

import AppIntents
/// Requests that the system open the iRiel application.
struct OpenIRielIntent: AppIntent {
    static let title: LocalizedStringResource = "Open iRiel"
    static let description = IntentDescription(
        "Opens the iRiel personal intelligence experience."
    )
    static let openAppWhenRun = true
    func perform() async throws -> some IntentResult {
        .result()
    }
}

openAppWhenRun declares that executing the intent should open the application. The perform() method returns a result without performing authentication, memory, or intelligence operations.

iRielAppShortcuts.swift

import AppIntents
struct iRielAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: OpenIRielIntent(),
            phrases: [
                "Open \(.applicationName)"
            ],
            shortTitle: "Open iRiel",
            systemImageName: "sparkles"
        )
    }
}

The phrase uses \(.applicationName) to associate the shortcut with the application name.

Availability depends on the target configuration, installation, and capabilities supported by the operating system version. The declaration alone does not guarantee that all Siri versions or Apple Intelligence features will be available.

4. Architecture

User
    |
    v
Siri / Shortcuts
    |
    v
OpenIRielIntent
    |
    | Requests that the application open
    v
iRiel AI App
    |
    +-- Interface and authentication
    |
    +-- iRiel Core / Intelligence Engine
        (outside the scope of this intent)

The intent must not create a direct connection to Core.

Any subsequent data loading or session management after the application opens belongs to the normal application flow and must comply with the relevant authentication and session contracts.

5. Integration into the Xcode Project

When the official native application repository becomes available:

1. Identify the official iRiel iOS target.
2. Add OpenIRielIntent.swift and iRielAppShortcuts.swift to the correct target.
3. Confirm that the target is compatible with AppIntents and with the minimum iOS version defined by the project.
4. Confirm that iRielAppShortcuts is compiled into the application target.
5. Build using the supported Xcode and SDK versions.
6. Run the tests.
7. Validate shortcut discovery and application opening in a compatible Apple environment.
8. Record the actual build and test results.

Integration must take place in the existing official application, without creating a separate Xcode project solely to simulate the implementation.

6. Acceptance Criteria

* [ ]	The files are integrated into the official native target.
* [ ]	The target builds with AppIntents.
* [ ]	The intent is recognized by supported integrations.
* [ ]	The shortcut is discoverable in the Shortcuts app in a compatible environment.
* [ ]	Execution requests that the iRiel application open.
* [ ]	The intent does not initiate sessions or create conversations.
* [ ]	The intent does not access memory or execute external tools.
* [ ]	There is no direct dependency on iRiel Core for the opening action.
* [ ]	Integration tests and validation have been executed, with the results recorded.

Criteria must only be marked as complete after verifiable evidence exists.

7. Testing Strategy

Contract Tests

Verify the intent metadata and opening configuration within the accessible and stable parts of the Swift contract.

Build Tests

Confirm that both files belong to the correct target and build successfully with the selected SDK.

Integration Tests

Verify that:

* The shortcut is presented by the system in a compatible environment.
* Execution requests that the application open.
* The intent does not introduce calls to Core, memory operations, authentication, or external tool execution.

Discovery in Shortcuts and actual application opening require integration validation. A test must not be reported as executed without recording the observed result.

8. Security and Privacy

The intent must not transport credentials, tokens, conversation content, or other personal data.

Because the basic action does not need to communicate with remote services, it must not introduce network dependencies or secrets.

Any future functionality that goes beyond opening the application must be specified separately, with defined responsibility boundaries, input validation, and dedicated tests.

9. Implementation Status

Component	Status
Contract and objective	Proposed and documented
Reference Swift code	Documented; integration not confirmed
Integration into official iOS target	Pending
Build in official project	Not verified
Discovery in Shortcuts	Not verified
Integration tests	Not executed or not confirmed

Important: the presence of this document in Git does not mean that the functionality has been implemented. The status must only be updated after inspecting the official project and validating the implementation.

10. Next Step

Identify the repository or directory containing the official native iOS application for iRiel AI, integrate both files into the existing target, and run the build and tests.

The ZIP files previously analyzed were not confirmed to contain a native Xcode project.

⸻

Architectural rule: OpenIRielIntent opens the application. It is not an entry point for iRiel Intelligence Engine orchestration.