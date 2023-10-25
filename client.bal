import ballerina/graphql;
import ballerina/io;

type Dev_ObjectivesResponse record {|
    record {|anydata dt;|} data;
|};

type KPIResponse record {|
    record {|anydata dt;|} data;
|};

type EmployeeResponse record {|
    record {|anydata dt;|} data;
|};

type HODResponse record {|
    record {|anydata dt;|} data;
|};

type SupervisorResponse record {|
    record {|anydata dt;|} data;
|};

type Supervisor record{
    string supID;
    string username;
    string? password;
    string empID;
};
type HOD record {
    string HOD_id;
    string HODname;
    string? password;
};
type Employee record {
    string emp_id;
    string EMPname;
    string? password;
    string supID;
    int score;
    string grade;
};

 type User  record {
      string  userId;
        string name;
        string accountType;
 };
graphql:Client graphqlClient = check new ("localhost:9090/EmployeeManagementSystem");

public function main() returns error? {
        io:println(MainMenu());
}
function MainMenu() returns string|error {
    io:println("1) Login");
   
   
    string input =io:readln("Please enter 1 to log in: ");

    if (input == "1") {
        return Login();
    }

    else {
        return Login();
    }    
}
function addedUser() returns string|error {

    string UserId = io:readln("Enter Username...");
    string Name = io:readln("Enter Password...");
    string accountType =io:readln("Enter Account Type...");
    User theUser = {
        userId: UserId,
        name: Name,
        accountType: accountType

};

    io:println(addedUser);

    string input = io:readln("\n\nEnter (1) to return to Exit");

    if input == "1" {
        return Login();
    }

    string|error var1 = addedUser();
    return addedUser()
};

function Login() returns string|error {


    io:println("-----Welcome to the EmployeeManagement System-----");

    io:println("\n\n1)HOD");
    io:println("2)Supervisor");
    io:println("3)Employee");




    string input = io:readln("\n\nWhich User Are you: ");

   // User user = check ep->getUser(id);

    if (input == "1") {
          return HODlogin();
    }

    else {
        return Login();
      
    }
    if (input == "2") {
          return SupMenu();
    }

    else {
        return Login();
      
    }
    if (input == "3") {
          return EmpMenu();
    }

    else {
        return Login();
      
    }

};
function HODlogin() returns string|error {
string User_id = io:readln("Enter User ID...");
string Name = io:readln("Enter User Username...");
string password = io:readln("Enter User Password...");

HOD theHOD = {
                  HOD_id:  User_id,
                  HODname : Name,
                  password: password
                  
    };

    io:println("1) Create Department Objectives");
    io:println("2) Delete Department Objectives");
    io:println("3) View Total Score Of Employees");
    io:println("4) Assign an employee to a Supervisor");
        //string addedUser = check ep->createUser(theUser);
        //io:println(addedUser);

if (input == "1") {

        string|error result = addDepObjectives();

        return result;

  }

   if (input == "2") {

        string|error result = deleteDepObjectives();

        return result;
   }


    if (input == "3") {

        string|error result = getTotalScores();

        return result;

    }

    if (input == "4") {

        string|error result = "Assign an employee to a Supervisor";

        return result;

    }

        string input=io:readln("\n\nEnter (1) to return to Exit ");


  };

  function SupMenu() returns string|error {

string UserId = io:readln("Enter supID...");
string Name = io:readln("Enter User Username...");
string password = io:readln("Enter User Password...");

HOD theSupervisor = { 
                          supID:  UserId,
                          username : Name,
                          password: password
                  
    ,HODname: "", HOD_id: ""};
  
    io:println("1) Approve Employee KPI");
    io:println("2) Delete Employee KPI");
    io:println("3) Update Employee KPI");
    io:println("4) View Employee scores for Assigned Employees");
    io:println("5) Grade Employee KPI");
   
   
        //string addedUser = check ep->createUser(theUser);
       // io:println(addedUser);

        string input=io:readln("\n\nEnter (1) to return to Exit ");

string input = io:readln("please choose a number: ");

 if (input == "1") {

        string|error result = "Approve Employee KPI";

        return result;

  }

   if (input == "2") {

        string|error result = deleteKPI();

        return result;
   }


    if (input == "3") {

        string|error result = addKPI();

        return result;

    }

    if (input == "4") {

        string|error result = getScore();

        return result;

    }
 if (input == "5") {

        string|error result = gradeKPI();

        return result;

    }



  function EmpMenu() returns string|error {
string UserId = io:readln("Enter supID...");
string Name = io:readln("Enter User Username...");
string password = io:readln("Enter User Password...");

HOD theEmployee = { 
                          emp_id:  UserId,
                          EMPname : Name,
                          password: password
                  
    ,HODname: "", HOD_id: ""};

    io:println("1) Create KPI");
    io:println("2) View Score");

        // string addedUser = check ep->createUser(theUser);
        // io:println(addedUser);

        string input=io:readln("\n\nEnter (1) to return to Exit ");

string input = io:readln("please choose a number: ");

if (input == "1") {

        string|error result = addKPI();

        return result;

  }

   if (input == "2") {

        string|error result = getScore();

        return result;
   }

  };
