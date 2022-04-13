# Flutter Dismissible

A Flutter project showing how to use a Dismissible widget with an AlertDialog widget for the confirmation..

## Important Notes

- Inside your `ListView.builder()` you will be creating `Dismissible` widgets.
- The `Dismissible` widgets have the `ListTile` widget as its child.
- `Dismissible` uses the `direction` property to control which way a user can swipe: startToEnd, endToStart, horizontal, vertical, up, down
- `Dismissible` has a `background` and a `secondaryBackground` property. Background for what is to be revealed when the user swipes in the direction that text is read. SecondaryBackground is the widget to reveal when swiping in the opposite direction.
- There is an `onDismiss` function that runs when a user has swiped in any direction far enough to complete the action (more than half way). It will be passed a direction value so you can do different things based on which way the user swiped.
- There is also a `confirmDismiss` function that gets the direction value. It runs AFTER the swiping action, but BEFORE the `onDismiss` is called. It needs to return something like `Future(()=>true)`. The value of the Boolean inside the `Future` will tell the `Dismissible` widget whether or not to run the `onDismiss` function.
