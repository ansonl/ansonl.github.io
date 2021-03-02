---
published: false
---
## Microsoft Teams iOS Client 'Dodge Deauthentication & Make Voice Calls' Bug

**In short:** Microsoft Teams iOS client login screen can be bypassed after organization mandated login expiration has expired by dismissing the login view and tapping on the enabled user-interface elements. This behavior can be repeated an unlimited amount of times to browse the sections of Teams and view protected data.
- _Expiration example: Organization mandates re-authentication period of 18 hours. The user is no longer authenticated 19 hours after initial login._
- Cached data such as notification, teams, and chat are available. 
- New Teams voice calls can be successfully joined with two way voice communication.

This behavior 