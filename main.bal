import ballerina/graphql;
import ballerina/io;

graphql:Client ep = check new ("localhost:9090/EmployeeManagementSystem");

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
        return createUser();
    }    
}
type User record {
    string UserId;
    string Name;
    
};



function createUser() returns string|error {

   string UserId = io:readln("Enter User ID...");
    string Name = io:readln("Enter User Name...");

    
     User theUser = {
     userId: UserId,
     name: Name,
     accountType: ""
     ,UserId: "", Name: ""};

     string addedUser = check ep->createUser(theUser);

     io:println(addedUser);

    string input = io:readln("\n\nEnter (1) to return to Exit");

    if input == "1" {
        return Login();
    }

    else {
        return("An erro occured.");

}
}
function HODMenu() returns string|error {
    io:println("1) Login");
   
   
    string input =io:readln("Please enter 1 to log in: ");

    if (input == "1") {
        return Login();
    }

    else {
        return ("An erro occured.");
    }


    
}

function SupMenu() returns string|error {
    io:println("1) Login");
   
   
    string input =io:readln("Please enter 1 to log in: ");

    if (input == "2") {
        return Login();
    }

    else {
        return ("An erro occured.");
    }
}

function EmpMenu() returns string|error {
    io:println("1) Login");
   
   
    string input =io:readln("Please enter 1 to log in: ");

    if (input == "3") {
        return Login();
    }

    else {
        return ("An erro occured.");
    }
}

function Login() returns string|error {


    io:println("-----Welcome to the EmployeeManagement System-----");

    io:println("\n\n1)HOD");
    io:println("2)Supervisor");
    io:println("3)Employee");




    string input = io:readln("\n\nWhich User Are you: ");

   // User user = check ep->getUser(id);

    if (input == "1") {
          return HODMenu();
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

}
function HODlogin() returns string|error {
string UserId = io:readln("Enter Username...");
string Name = io:readln("Enter User Password...");


HOD theHOD = {
                  HOD_id: "",
                  password : "",
                  
    HODname: ""};

        string addedUser = check ep->createUser(theUser);
        io:println(addedUser);

        string input=io:readln("\n\nEnter (1) to return to Exit ");


  }
