# Carpool 2.0

Carpool 2.0 is a cutting-edge ridesharing solution tailored for the academic community, specifically addressing transportation needs to and from Abdu-Basha to various destinations. Upholding safety and community spirit, the platform mandates users to sign in using their active @eng.asu.edu.eg accounts, fostering a trusted closed community environment.

Operated by students for students, Carpool 2.0 introduces innovative strategies in driver recruitment and service management. This pilot project focuses on streamlining rides to two designated destination points – Gate 3 and 4 – with fixed departure and return times. Departures are scheduled at 7:30 am from various locations to either of the two gates, while the return ride is set at 5:30 pm from the Faculty of Engineering campus.

To ensure a seamless experience, customers are required to reserve their seats in advance. Reservations for the 7:30 am ride must be made before 10:00 pm the previous day, while reservations for the 5:30 pm return ride must be made before 1:00 pm on the same day.

Additionally, a mobile application will be developed for drivers to confirm orders and update status data. Orders must be confirmed before 11:30 pm for the morning ride and before 4:30 pm for the afternoon ride, ensuring timely coordination between drivers and passengers.

## Documentation

For detailed documentation of the project, please refer to [Documentation File]([link-to-documentation-file](https://github.com/ZiadKasem/MobileProgramming-CarPool/tree/master/Documentation)).

## Video Demo

Check out our video demo showcasing the features and functionality of Carpool 2.0: [Video Demo]([link-to-video](https://drive.google.com/file/d/1Qa9fiA2buVEiXOmwkUKgDITGi76xyibK/view)).

## Specifications (Features)

### For Passenger App

1. **Authentication:**
   - **Login Page:**
     - Implement Firebase Authentication for secure user login.
     - Include a "Sign Up" option for new users.
     - Provide testing credentials for testing purposes.

2. **Home Page:**
   - **Route Information:**
     - Display a list of available routes to and from Ainshams Campus.
     - Utilize a Recycler View for organized and user-friendly display.
     - Include the status of each route.
   - **Reservation:**
     - Allow users to select a route to reserve.

3. **Cart Page:**
   - **Order Review:**
     - Provide a cart page for users to review their selected route.
     - Include options for making payments.
   - **Confirmation:**
     - Implement a confirmation button for finalizing reservations.

4. **Order History:**
   - **Tracking/Status Page:**
     - Enable users to view a history of their requested rides.
     - Include a tracking/status page for each ride.

5. **Database Integration:**
   - **Firebase Real-time Database:**
     - Utilize Firebase Real-time Database for storing route information and order status.
   - **Local Database (SQLite):**
     - Store a copy of profile data for passengers locally using SQLite.
     - Ensure synchronization with Firebase for consistency.

6. **Order Tracking Page:**
   - **Status Updates:**
     - Implement a page for users to track the status of their reservations.
     - Display detailed ride information.

7. **Profile Page:**
   - **User Profile:**
     - Enable users to edit their profile information.
     - Ensure updates reflect in both the local database and Firebase.

### For Driver App

1. **Authentication:**
   - **Login Page:**
     - Implement Firebase Authentication for secure user login.
     - Include a "Sign Up" option for new users.
     - Provide testing credentials for testing purposes.

2. **Home Page:**
   - **Route Information:**
     - Display a list of routes belonging to the current Driver to and from Ainshams Campus.
     - Utilize a Recycler View for an organized and user-friendly display.
     - Include the status of each route.

3. **Add Route Page:**
   - **Order Review:**
     - Provide an Add route page for Drivers to add route details such as Date, Time, Source, Destination, and Price.
     - Implement a confirmation button for finalizing Adding route.

4. **Database Integration:**
   - **Firebase Real-time Database:**
     - Utilize Firebase Real-time Database for storing route information and order status.
   - **Local Database (SQLite):**
     - Store a copy of profile data for drivers locally using SQLite.
     - Ensure synchronization with Firebase for consistency.

5. **Ride Tracking Page:**
   - **Status Updates:**
     - Implement a page for drivers to track the status of passengers' reservations.
     - Accept or reject passengers.
     - Change the State of Trip.
     - Display detailed ride information.

6. **Profile Page:**
   - **User Profile:**
     - Enable drivers to edit their profile information.
     - Ensure updates reflect in both the local database and Firebase.

## Screens Layouts

**Driver:**
- Login Screen & Signup Screen
- HomeScreen
- Add Ride Screen
- Profile Page
- Review Your ride

**Passenger:**
- Login and Signup screens
- Profile & Order History
- Homepage
- Order Tracking page & Cart page

**For Testing Layouts:**
- Passenger Homepage & Driver homepage

## Database Structure

**Local Database Structure**

**For Driver:**
- Table: drivers
  - Columns:
    - id (TEXT, PRIMARY KEY): Uniquely identifies each driver.
    - name (TEXT): Stores the driver's name.
    - email (TEXT): Stores the driver's email address.
    - phone (TEXT): Stores the driver's phone number.
  - Additional Notes:
    - Database file: "DRIVERPROJECTDB" stored in the application's data directory.
    - Database version: 1.

**For Passenger:**
- Table: users
  - Columns:
    - id (TEXT, PRIMARY KEY): Uniquely identifies each user.
    - name (TEXT): Stores the user's name.
    - email (TEXT): Stores the user's email address.
    - phone (TEXT): Stores the user's phone number.
  - Additional Notes:
    - Database file: "USERPROJECTDB" stored in the application's data directory.
    - Database version: 1.

## Test Case Scenarios

1. Group of test scenarios for sign-Up page
   - Various scenarios testing name, phone number, email, and password validations.
   
2. Test case Login
   - Scenarios testing login functionality with valid and invalid credentials.

3. Test case Add ride For Driver
   - Scenarios testing the addition of rides by drivers with various inputs.

4. Test case Driver Navigate to profile Page
   - Scenarios testing driver profile page functionality under different network conditions.

5. Test Case Edit Profile Page
   - Scenarios testing profile editing functionality with valid and invalid inputs.

6. Test case Driver Time Constraints
   - Scenarios testing driver actions within time constraints for accepting or rejecting passengers.

7. Test Case Logout for both drivers/passengers
   - Scenarios testing logout functionality for both drivers and passengers.

8. Test case Accept/reject ride in Driver App
   - Scenarios testing driver actions for accepting or rejecting ride requests.

9. Test case Passenger check the assigned ride
   - Scenarios testing passenger view of assigned rides.

10. Test case Passenger Time Constraints on reserve a ride
    - Scenarios testing passenger's ability to view and request rides within time constraints.
