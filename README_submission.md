# Moneybox iOS Technical Challenge - Developer notes

This file outlines my thinking in tackling the Technical Challenge.

## Initial thoughts

Unordered observations on reading the brief.

- Does it build and run as-is from initial checkout?  Yes.  Xcode 15.0, iPhone 15 simulator, built on a 2020 13" MacBook Air. No icon.
- Three screens.  Build all or progress through in turn?
- UIKit preferred.  So, let's avoid MMVC. MVVM?  For this that's more straightforward than e.g. VIPER.  Some scope for TCA/Redux?  Could include a simple off-the-shelf reducer.    
- Testing... MVVM is also then suggested to move as much of the business logic out of the controller. 
- Accessibility.  Noted.  Also, Dark/light?
- Existing code structure... what have we got? Network stack is provided; will need to be tested early on.  Less important to test these, the assumption being that since they're provided they should be OK.  But assumptions can always be challenged.
- Only target iPhone?  Only make allowances for e.g. iPad if there's time.  Different screen sizes should be accommodated.  Check on SE and Max versions.
- Git - master branch will suffice for now.  No need for more advanced strategy.  .gitignore doesn't exclude .DS_Store


## Plan of attack

- Icon
    - Quick search doen't throw up anything large enough.  Playstore.  Good enough for now.  Converted and added.
- Updated .gitignore
- Bring the README and wireframe into the project for ease of access.
- Design screens.  The first two initially, to then unblock login functionality

