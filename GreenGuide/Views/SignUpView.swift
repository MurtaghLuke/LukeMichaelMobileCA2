//
//  SignUpView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct SignUpView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var agreed = false
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 0) {
            header

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    inputField(
                        title: "Full Name",
                        placeholder: "John Doe",
                        icon: "person",
                        text: $fullName,
                        isSecure: false
                    )

                    inputField(
                        title: "Email",
                        placeholder: "your@email.com",
                        icon: "envelope",
                        text: $email,
                        isSecure: false
                    )

                    inputField(
                        title: "Password",
                        placeholder: "Create password",
                        icon: "lock",
                        text: $password,
                        isSecure: !showPassword,
                        trailingIcon: showPassword ? "eye.slash" : "eye"
                    ) {
                        showPassword.toggle()
                    }

                    inputField(
                        title: "Confirm Password",
                        placeholder: "Confirm password",
                        icon: "lock",
                        text: $confirmPassword,
                        isSecure: !showConfirmPassword,
                        trailingIcon: showConfirmPassword ? "eye.slash" : "eye"
                    ) {
                        showConfirmPassword.toggle()
                    }

                    Button {
                        agreed.toggle()
                    } label: {
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: agreed ? "checkmark.square.fill" : "square")
                                .foregroundColor(agreed ? .green : .gray)
                                .font(.system(size: 22))

                            Text("I agree to the Terms & Conditions and Privacy Policy")
                                .font(.subheadline)
                                .foregroundColor(.black.opacity(0.75))
                        }
                    }
                    .padding(.top, 10)

                    Button {
                        if fullName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                            errorMessage = "Please fill in all fields."
                        } else if password.count < 6 {
                            errorMessage = "Password must be at least 6 characters."
                        } else if password != confirmPassword {
                            errorMessage = "Passwords do not match."
                        } else if !agreed {
                            errorMessage = "Please accept the terms."
                        } else {
                            let success = AuthManager.shared.signUp(
                                fullName: fullName,
                                email: email,
                                password: password
                            )

                            if success {
                                errorMessage = ""
                                isLoggedIn = true
                            } else {
                                errorMessage = "An account with this email already exists."
                            }
                        }
                    } label: {
                        Text("Create Account")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 58)
                            .background(agreed ? Color.green : Color.gray.opacity(0.5))
                            .cornerRadius(18)
                    }
                    .disabled(!agreed)
                    .padding(.top, 18)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.subheadline)
                    }

                    divider

                    socialButton(title: "Sign up with Google")
                }
                .padding(.horizontal, 26)
                .padding(.top, 45)
                .padding(.bottom, 40)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(false)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Create Account")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)

            Text("Join Greenguide Ireland today")
                .font(.system(size: 18))
                .foregroundColor(.white.opacity(0.9))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 26)
        .padding(.top, 75)
        .padding(.bottom, 42)
        .background(Color.green)
    }

    private var divider: some View {
        HStack {
            Rectangle()
                .fill(Color.gray.opacity(0.25))
                .frame(height: 1)

            Text("OR")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal, 12)

            Rectangle()
                .fill(Color.gray.opacity(0.25))
                .frame(height: 1)
        }
        .padding(.vertical, 20)
    }

    private func socialButton(title: String) -> some View {
        Button {
            errorMessage = "\(title) is coming soon."
        } label: {
            HStack(spacing: 14) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 22, height: 22)

                Text(title)
                    .font(.headline)
                    .foregroundColor(.black.opacity(0.75))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.25), lineWidth: 1.5)
            )
            .cornerRadius(16)
        }
    }

    private func inputField(
        title: String,
        placeholder: String,
        icon: String,
        text: Binding<String>,
        isSecure: Bool,
        trailingIcon: String? = nil,
        trailingAction: (() -> Void)? = nil
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black.opacity(0.75))

            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .font(.system(size: 22))
                    .frame(width: 30)

                if isSecure {
                    SecureField(placeholder, text: text)
                } else {
                    TextField(placeholder, text: text)
                        .keyboardType(title == "Email" ? .emailAddress : .default)
                        .textInputAutocapitalization(.never)
                }

                if let trailingIcon = trailingIcon {
                    Button {
                        trailingAction?()
                    } label: {
                        Image(systemName: trailingIcon)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 18)
            .frame(height: 58)
            .background(Color.gray.opacity(0.06))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1.5)
            )
            .cornerRadius(16)
        }
    }
}

#Preview {
    NavigationStack {
        SignUpView()
    }
}
