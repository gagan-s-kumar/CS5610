# Tasktracker

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

#################################### Steps and Design Decisions of App ################################

## Register a User
  
  * If this is the first time you are visting the app, you need to register with your name and mailID
  * Click on the "Register" button in the home page and submit your details
  * Once submitted, youhave to vist the Home page (tasks1.gaganandkumar.com) and Log in

## Creating a Task

  * All the fields of form of new task page are mandatory. 
  * If the assigner doesn't know the Owner ID of the person to whom the task needs to be assigned,
      - Then the assigner should see the Owner ID next to the person by clicking "See Owners"
      - The Assigner should then use this ID while creating the task
  * By default, the value of Completed field will be false.

## Database Design Decision

  - Owner Table
  * It has got 2 fields viz, email and name. 
  * Both are mandatory and can't be null
  * This decision was made since email will be used for Login purpose and Name is required for identification

  - Task Table
  * It has got 5 fields viz, owner_id, title, description, duration and completed
  * All the fields of Task Table are mandatory. The justification for each is given below:
    - owner_id    : Since every owner created in the Owner Table will have a unique ID, we can leverage this 
                    to our advantage in Task Table. There might be chances that two users might have the same 
                    name. Hence having a drop down option with owner name will not be a good design.
    - title       : A new task should have a title to destinguish it from the rest
    - description : It has been mentioned in the question that description is also required for creation
    - duration    : I wanted to make default value of duration as 0, but over ruled that design since the 
                    assigned should have an idea for the time the tasks takes and also, since there is a check 
                    for multiple of 15 mins, I made it as non-null with no default value
    - completed   : The default value of this field is set to false. This assumption was made since if a task
                    being created, it is very unlikely that it is already completed as well. However, the user
                    can override the default value and check the box to mark the field as completed

  - Other Decisions:
    
    - I decided to delete the tasks associated with the owner deletion since owner_id in Task Table can't be null.
      Also if the owner himself is removed, there is no point in keeping the tasks that he had created to keep track

Thank you. 
