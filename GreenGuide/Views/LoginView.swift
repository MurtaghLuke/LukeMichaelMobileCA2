//
//  LoginView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct LoginView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var showSignUp = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header

                VStack(alignment: .leading, spacing: 22) {
                    inputField(
                        title: "Email",
                        placeholder: "your@email.com",
                        icon: "envelope",
                        text: $email,
                        isSecure: false
                    )

                    inputField(
                        title: "Password",
                        placeholder: "Enter password",
                        icon: "lock",
                        text: $password,
                        isSecure: !showPassword,
                        trailingIcon: showPassword ? "eye.slash" : "eye"
                    ) {
                        showPassword.toggle()
                    }

                    Button {
                        if email.isEmpty || password.isEmpty {
                            errorMessage = "Please enter your email and password."
                        } else if AuthManager.shared.login(email: email, password: password) {
                            errorMessage = ""
                            isLoggedIn = true
                        } else {
                            errorMessage = "Incorrect email or password."
                        }
                    } label: {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 58)
                            .background(Color.green)
                            .cornerRadius(18)
                    }
                    .padding(.top, 25)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.subheadline)
                    }

                    divider

                    socialButton(title: "Continue with Google")
                    socialButton(title: "Continue with Facebook")

                    HStack {
                        Spacer()

                        Text("Don’t have an account?")
                            .foregroundColor(.gray)

                        Button("Sign Up") {
                            showSignUp = true
                        }
                        .foregroundColor(.green)
                        .fontWeight(.semibold)

                        Spacer()
                    }
                    .padding(.top, 18)
                }
                .padding(.horizontal, 26)
                .padding(.top, 45)

                Spacer()
            }
            .ignoresSafeArea(edges: .top)
            .navigationDestination(isPresented: $showSignUp) {
                SignUpView()
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Welcome Back")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)

            Text("Sign in to continue your journey")
                .font(.system(size: 18))
                .foregroundColor(.white.opacity(0.9))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 26)
        .padding(.top, 95)
        .padding(.bottom, 48)
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
    LoginView()
}
