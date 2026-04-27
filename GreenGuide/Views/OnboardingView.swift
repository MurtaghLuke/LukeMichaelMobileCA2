//
//  OnboardingView.swift
//  GreenGuide
//
//  Created by Student on 24/04/2026.
//
import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    let pages = [
        OnboardingPage(
            icon: "house",
            title: "Discover Ireland",
            description: "Find unique accommodations across the Emerald Isle, from cozy cottages to castle stays"
        ),
        OnboardingPage(
            icon: "mappin",
            title: "Explore Locations",
            description: "Browse properties by region and discover hidden gems throughout Ireland"
        ),
        OnboardingPage(
            icon: "calendar",
            title: "Easy Booking",
            description: "Book your perfect Irish getaway in just a few taps with instant confirmation"
        )
    ]

    var body: some View {
        VStack {
            Spacer()

            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    OnboardingPageView(page: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            PageIndicator(currentPage: currentPage, pageCount: pages.count)
                .padding(.bottom, 35)

            Button {
                if currentPage < pages.count - 1 {
                    withAnimation {
                        currentPage += 1
                    }
                } else {
                    hasSeenOnboarding = true
                }
            } label: {
                Text(currentPage == pages.count - 1 ? "Get Started" : "Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(18)
            }
            .padding(.horizontal, 28)

            Button {
                hasSeenOnboarding = true
            } label: {
                Text("Skip")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.top, 18)
            }

            Spacer().frame(height: 30)
        }
        .background(Color.white)
    }
}

struct OnboardingPage {
    let icon: String
    let title: String
    let description: String
}

struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 110, height: 110)

                Image(systemName: page.icon)
                    .font(.system(size: 48, weight: .regular))
                    .foregroundColor(.white)
            }

            Text(page.title)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)

            Text(page.description)
                .font(.system(size: 22))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineSpacing(6)
                .padding(.horizontal, 35)

            Spacer()
        }
    }
}

struct PageIndicator: View {
    let currentPage: Int
    let pageCount: Int

    var body: some View {
        HStack(spacing: 9) {
            ForEach(0..<pageCount, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage ? Color.green : Color.gray.opacity(0.25))
                    .frame(width: index == currentPage ? 34 : 10, height: 10)
                    .animation(.easeInOut, value: currentPage)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
