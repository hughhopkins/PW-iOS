# PW-iOS

Available on the App Store: https://itunes.apple.com/app/apple-store/id981716752?pt=117760826&ct=GitHub&mt=8.

Based on https://github.com/simontabor/pw and outputs the same passwords.

Big up to https://github.com/krzyzanowskim/CryptoSwift for hashing.

## What is it?

Create unique theft proof passwords for each service that you use. Never store them but easily create them when you need it.

Simply enter a service and then a password. PW will then hash it using SHA1 and now you have super strong and unique password for that site.

## How does it work?

PW takes the two inputs Service and Password and runs it through a SHA1 hash with four pipes thrown in to make it a little interesting:

SHA1(“Service” + “||” + “Password” + “||”)

For example with the service “facebook” and the password “hackference” it would be:

SHA1(facebook||hackference||)

and output:

762b679fA17b10D6Cc2d2194542d2235738b3e33