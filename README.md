# Welcome to PharmaDash

A Vue.js(Quasar) + Phoenix Application

## Instructions for running the application in your local environment.

Ensure that you have Phoenix 1.4+, and the latest versions of Elixir and Erlang installed on your machine.
In server directory, run `mix deps.get` and then `mix phx.server` to start the server in local development mode on port 4000.

Make sure you have node >=8 installed on your machine.
If you do not have the quasar cli installed via `npm install -g @quasar/cli` or do not wish to install it globally, feel free to use the `npx quasar dev` as an alternative.
In client directory, run `npm install` and then `quasar dev` to start the client in local development mode on port 8080.

Server is currently configured to allow CORS requests from localhost:8080, with withCredentials set to true in the request headers. Please make sure you are using pot 8080 to run the client.

Edit the dex.exs folder in the config directory to point the phoenix server to your local (or remote) postgres database.

## Navigating the application

Once both the server and the client are running, navigate to localhost:8080 in your browser of choice.

The application flow is self-explanatory. Choose an entity, create a user, then sign-in. Pharmacy users can
view orders, cancel/uncancel orders, add new patients, add new couriers, and create new orders associated with a patient and a courier.

Courier users can view orders, set orders as delivered, undeliverable and vic versa.

### What was the hardest part of the implementation?

Designing the user experience was the most difficult part of me, conceptually. In particular, ensuring that data was loaded when it needed to be, hiding complexity from the user, giving the user feedback for all of their actions, catching errors and displaying messages, and managing the state of the application as the user moves through the different screens was the most difficult part for me. For example, I choose to break up the process of creating an order into three different processes; one for adding a courier, one for adding a new patient, and one for creating an order associated with a courier and a patient. Putting all three of these processes into one large form would have been daunting for the user and would have made it more difficult to provide feedback or error messages during any point in the processes. It seemed natural that an order should be associated with a patient and a courier, and smoothing out that creation process took some time to think through.

Technically, the most difficult part was creating the foreign key relationships amongst the different schemas in the backend. I knew that I wanted to be able to create patients, pharmacies, and couriers separately, and then associate them together in the process of creating orders. However, it was not clear to me how to accomplish this with Ecto's api. I was trying to avoid directly adding the foreign key relationships into the different resources since, coming from a Python Django background, I assumed that that would be wrong and cause all types of errors. Django had accostumed me to relying on the ORM to build all of my relationships for me. I am still not sure if it was the correct way to do it, but once I decided to simply add the foreign key relationships directly, I realized how much power Phoenix/Ecto gives you to manipulat associations. Although it is more laborious ( generate a new migration, modify the schema, then alter the controllers to insert the appropriate foreign keys), I appreciate how explicit and transperant the process of buidling associations is with Ecto.

### What would be your next couple of tasks if you had more time?

If I had more time, I would do two things. First, I would create a real permission system for the backend to ensure that users may only edit, delete, or view resourcers owned by their organization. This would involve writing a new plug to look up the users organization (pharmacy or courier), and checking it against the ownership of every resource prior to allowing access. I wrote two small plugs related to authentication, but this plug would have taken me longer since I have never written anything like it this using Phoenix or otherwise. Additionally, writing a suit of tests for the new functionality would be a new experience for me as well, and this is exactly the kind of thing that needs robust testing.

The second thing would be to create a role-based authentication system for the client-side routing, to ensure that users only have access to permitted routes within the client. Since I used a url-based routing system for the SPA client, it is currently possible for users to directly nagivate into routes they are not authorized to view. However, since all backend resources are authenticated using session cookies, any user playing around in routes they are not supposed to be in should not be able to do any damage at the moment. However, this feature is clealry a priority.

### How could we change the project to be more interesting?

I think that an alternative project based on Elixir and leveraging OTP would be more interesting. Designing supervision trees, spawning new processes and thinking about fault tolerance with OTP is the most interesting part of Elixir, so a small project using these capabilities would be fun. I am not sure what that project would be, but that is my inclination. Phoenix is fun as well, but Phoenix does too good of a job hiding the capabilities of OTP behind the scenes.
