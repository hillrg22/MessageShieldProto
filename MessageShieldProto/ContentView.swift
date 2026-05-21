import SwiftUI

// MARK: - Root App View

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                SetupStatusSection()
                HowItWorksSection()
                RulesSection()
                AboutSection()
            }
            .navigationTitle("MessageShield")
        }
    }
}

// MARK: - Setup Status

struct SetupStatusSection: View {
    // In a real app, you'd check if the extension is actually enabled
    // via ILMessageFilterExtension's enabledState API (iOS 16+)
    @State private var isEnabled = false

    var body: some View {
        Section {
            HStack(spacing: 12) {
                Image(systemName: isEnabled ? "checkmark.shield.fill" : "shield.slash.fill")
                    .font(.title2)
                    .foregroundColor(isEnabled ? .green : .orange)

                VStack(alignment: .leading, spacing: 2) {
                    Text(isEnabled ? "Filter Active" : "Filter Not Enabled")
                        .font(.headline)
                    Text(isEnabled
                         ? "Unknown messages are being screened on-device."
                         : "Follow the steps below to activate.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)

            if !isEnabled {
                Button {
                    openMessagesSettings()
                } label: {
                    Label("Open Settings → Messages", systemImage: "gear")
                }
            }
        } header: {
            Text("Status")
        }
    }

    private func openMessagesSettings() {
        // Deep-links directly to Messages settings on iOS 16+
        if let url = URL(string: "App-prefs:MESSAGES") {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - How It Works

struct HowItWorksSection: View {
    var body: some View {
        Section {
            StepRow(number: "1", title: "Open Settings → Messages",
                    detail: "Scroll to \"Unknown & Spam\" and tap \"Filter Unknown Senders\".")
            StepRow(number: "2", title: "Select MessageShield",
                    detail: "Under SMS Filtering, choose MessageShield as your filter app.")
            StepRow(number: "3", title: "You're done",
                    detail: "Messages from unknown numbers are classified on this device. No data ever leaves your phone.")
        } header: {
            Text("Setup")
        }
    }
}

struct StepRow: View {
    let number: String
    let title: String
    let detail: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(number)
                .font(.headline)
                .frame(width: 26, height: 26)
                .background(Color.accentColor.opacity(0.15))
                .clipShape(Circle())
                .foregroundColor(.accentColor)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.subheadline).fontWeight(.medium)
                Text(detail).font(.caption).foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 2)
    }
}

// MARK: - Rules (placeholder for a future rule editor UI)

struct RulesSection: View {
    var body: some View {
        Section {
            NavigationLink("Spam Patterns") {
                RuleListView(category: "Spam")
            }
            NavigationLink("Promotion Patterns") {
                RuleListView(category: "Promotions")
            }
            NavigationLink("Sender Allowlist") {
                RuleListView(category: "Allowed Senders")
            }
        } header: {
            Text("Filter Rules")
        } footer: {
            Text("Rules are evaluated on-device before the ML model runs.")
        }
    }
}

struct RuleListView: View {
    let category: String
    var body: some View {
        List {
            Text("Rule editing UI goes here.")
                .foregroundColor(.secondary)
        }
        .navigationTitle(category)
    }
}

// MARK: - About

struct AboutSection: View {
    var body: some View {
        Section {
            LabeledContent("Classification", value: "On-device only")
            LabeledContent("Network access", value: "None")
            LabeledContent("Data collected", value: "None")
        } header: {
            Text("Privacy")
        } footer: {
            Text("MessageShield never transmits message content. All classification happens locally using on-device rules and a bundled ML model.")
        }
    }
}

#Preview {
    ContentView()
}

