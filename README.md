# odin-knights-travails

This is a program I made for the The Odin Project online curriculum. It finds the shortest path a knight has to take to move from one square on a chess board to another.

I used the built-in Vector class to make calculating the moves a bit more intuitive. The key lesson was to recognize that a breadth-first algorithm was gonna be best in this case. Depth-first would get the program lost on a path to nothing from the get-go.

Another thing that threw me was getting the Node class's history to work. Initially, I was passing a history parameter to the #initialize method and then assigning an instance variable to that parameter. But I think passing in the parent's history like this caused the child's and parent's instance variables to point at the same object. Appending to the child's history would also append to the parent's, until I changed the Node#initialize method to create an empty array for each new Node instance and then append the history that was passed in to that array in a separate step.

I don't really understand why the assignment wanted me to create a board. It seems to me like you could just as well reject potential children with negative or out-of-bounds coordinates.