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
 };
 type Dep_Objectives record{
    string Obj_id;
    string Obj_name;
    string HOD_id;
};
type KPI record {
    string KPIname;
    string KPI_id;
    string emp_id;
    string Dep_id;
    boolean isValid;
    int score;
    string grade;
    string supID;
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

    User theUser = {
        userId: UserId,
        name: Name

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

        //string addedUser = check ep->createUser(theUser);
        //io:println(addedUser);

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

        //string addedUser = check ep->createUser(theUser);
       // io:println(addedUser);

        string input=io:readln("\n\nEnter (1) to return to Exit ");



  };

  function EmpMenu() returns string|error {
string UserId = io:readln("Enter supID...");
string Name = io:readln("Enter User Username...");
string password = io:readln("Enter User Password...");

HOD theEmployee = { 
                          emp_id:  UserId,
                          EMPname : Name,
                          password: password
                  
    ,HODname: "", HOD_id: ""};

        // string addedUser = check ep->createUser(theUser);
        // io:println(addedUser);

        string input=io:readln("\n\nEnter (1) to return to Exit ");


  };

  public function addDepObjectives(graphql:Client graphqlClient, Dep_Objectives objective) returns error? {

     string addDoc = string `
        mutation addDepObjectivest($Obj_id:String!,$name:String!,$user_id:String!){
        addDepObjectives(newObjective:{Obj_id:$Obj_id,name:$name,user_id})  {
         Obj_id
         name
         user_id
        }
    }`;
    string Obj_id = io:readln("Enter Objective Id:");
    string name = io:readln("Enter department name:");
    string user_id = io:readln("Enter user ID");
     Dev_ObjectivesResponse addDev_Objectives = check graphqlClient->execute(addDoc, {"Obj_id":Obj_id, "user_id":user_id, "name":name});
    io:println("Response ", addDev_Objectives);
        string exitSys = io:readln("Press 0 to go back");

        if (exitSys === "0") {
            error? rerun = main();
            if rerun is error {
                io:println("Error, You can't go back to options page.");
            }
        
     }
  }
    public function addKPI(graphql:Client graphqlClient, KPI kpi) returns error? {
       
        string addDoc2 = string `
        mutation addKPI($KPIname:String!,$KPI_id:String!,$score:Int!){
        addKPI(newKPI:{KPI_id:$KPI_id,KPIname:$KPIname,score:$score})  {
         KPI_id
         KPIname
         score
        }
    }`;
     string KPI_id = io:readln("Enter KPI Id:");
    string KPIname = io:readln("Enter KPI name:");
    string score = io:readln("Enter score");
     Dev_ObjectivesResponse addDev_Objectives = check graphqlClient->execute(addDoc2, {"KPI_id":KPI_id, "KPIname":KPIname, "score":score});
    io:println("Response ", addDev_Objectives);
        string exitSys = io:readln("Press 0 to go back");

        if (exitSys === "0") {
            error? rerun = main();
            if rerun is error {
                io:println("Error, You can't go back to options page.");
            }
        
     }
    }

    public function deleteDepObjectives(graphql:Client graphqlClient,Dep_Objectives objectives ) returns error? {
         string deleteDoc = string `
        mutation deleteDepObjectives($Obj_id: String!) {
        deleteDepObjectives(Obj_id: $Obj_id) {
          success
           message
            }
        }
    `;

     string Obj_id = io:readln("Enter Objective Id:");

     Dev_ObjectivesResponse deleteDev_Objectives = check graphqlClient->execute(deleteDoc, {"Obj_id":Obj_id});
    io:println("Response ", deleteDev_Objectives);
        string exitSys = io:readln("Press 0 to go back");

        if (exitSys === "0") {
            error? rerun = main();
            if rerun is error {
                io:println("Error, You can't go back to options page.");
            }
        
     }

    }

    public function addHOD(graphql:Client graphqlClient, HOD hod) returns error? {
       
        string addDoc2 = string `
        mutation addHOD($HOD_id:String!,$HODname:String!,$password:String!){
        addSupervisor(newKPI:{HOD_id:$HOD_id,HODname:$HODname,password:$password})  {
         HOD_id
         HODname
         password
        }
    }`;
     string HOD_id = io:readln("Enter HOD Id:");
    string HODname = io:readln("Enter HOD name:");
    string password = io:readln("Enter your Password");
     Dev_ObjectivesResponse addHOD = check graphqlClient->execute(addDoc2, {"HOD_id":HOD_id, "HODname":HODname, "password":password});
    io:println("Response ", addHOD);
        string exitSys = io:readln("Press 0 to go back");

        if (exitSys === "0") {
            error? rerun = main();
            if rerun is error {
                io:println("Error, You can't go back to options page.");
            }
        
     }
    }

    public function addSupervisor(graphql:Client graphqlClient, Supervisor sup) returns error? {
       
        string addDoc3 = string `
        mutation addSupervisor($sup_id:String!,$username:String!,$password:String!){
        addSupervisor(newKPI:{sup_id:$sup_id,username:$username,password:$password})  {
         sup_id
         username
         password
        }
    }`;
     string sup_id = io:readln("Enter Supvisor Id:");
    string username = io:readln("Enter User name:");
    string password = io:readln("Enter your Password");
     Dev_ObjectivesResponse addSUP = check graphqlClient->execute(addDoc3, {"sup_id":sup_id, "username":username, "password":password});
    io:println("Response ", addSUP);
        string exitSys = io:readln("Press 0 to go back");

        if (exitSys === "0") {
            error? rerun = main();
            if rerun is error {
                io:println("Error, You can't go back to options page.");
            }
        
     }
}

    public function addEmployee(graphql:Client graphqlClient, Employee emp) returns error? {
       
        string addDoc4 = string `
        mutation addEmployee($emp_id:String!,$username:String!,$password:String!){
        addKPI(newKPI:{emp_id:$emp_id,username:$username,password:$password})  {
         emp_id
         username
         password
        }
    }`;
     string emp_id = io:readln("Enter Employee Id:");
    string username = io:readln("Enter User name:");
    string password = io:readln("Enter your Password");
     Dev_ObjectivesResponse addEMP = check graphqlClient->execute(addDoc4, {"emp_id":emp_id, "username":username, "password":password});
    io:println("Response ", addEMP);
        string exitSys = io:readln("Press 0 to go back");

        if (exitSys === "0") {
            error? rerun = main();
            if rerun is error {
                io:println("Error, You can't go back to options page.");
            }
        
     }
    }

