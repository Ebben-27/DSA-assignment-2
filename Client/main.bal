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
        return MainMenu();
    }    
}
public function addHOD(graphql:Client graphqlClient, HOD hod) returns string|error {
       
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

    string input = io:readln("\n\nEnter (1) to return to Exit");

    if input == "1" {
        return Login();
    }
}

 public function addSupervisor(graphql:Client graphqlClient, Supervisor sup) returns string|error {
       
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

    string input = io:readln("\n\nEnter (1) to return to Exit");

    if input == "1" {
        return Login();
    }
}
public function addEmployee(graphql:Client graphqlClient, Employee emp) returns string|error {
       
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

    string input = io:readln("\n\nEnter (1) to return to Exit");

    if input == "1" {
        return Login();
    }
}

function Login() returns string|error {


    io:println("-----Welcome to the Employee Management System-----");

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
          return Suplogin();
    }

    else {
        return Login();
      
    }
    if (input == "3") {
          return Emplogin();
    }

    else {
        return Login();
      
    }

}

function HODlogin() returns string|error {
string User_id = io:readln("Enter HOD ID...");
string Name = io:readln("Enter User Username...");
string password = io:readln("Enter User Password...");

HOD theHOD = {
                  HOD_id:  User_id,
                  HODname : Name,
                  password: password
                  
    };

    io:println("HOD Log in successful"); 

  string input=io:readln("\n\nEnter (1) to return to Continue to HodMenu ");

        if (input == "1") {
        return HODMenu();
    }

    else {
        return Login();
    }    


  }

  function HODMenu() returns string|error {


    io:println("-----What would you like to do -----");

    io:println("\n\n1)Create department objectives");
    io:println("2)Delete department objectives");



    string input = io:readln("\n\nPlease Pick an option: ");


    if (input == "1") {
          return addDepObjMenu();
    }

    else {
        return HODMenu();
      
    }
    if (input == "2") {
          return deleteObjMenu();
    }

    else {
        return HODMenu();
      
    }
    
}

  function Suplogin() returns string|error {

string UserId = io:readln("Enter supID...");
string Name = io:readln("Enter User Username...");
string password = io:readln("Enter Password...");

    io:println("Supervisor Log in successful"); 


        string input=io:readln("\n\nEnter (1) to continue to Supervisor Menu ");


  };

  function SUPMenu() returns string|error {

   io:println("-----What would you like to do -----");

    io:println("1)Delete Employee’s KPIs");
    io:println("2)Update Employee's KPIs");

    string input = io:readln("\n\nPlease Pick an option: ");


    if (input == "1") {
          return deleteKPIMenu();
    }

    else {
        return SUPMenu();
      
    }
    if (input == "2") {
          return UpdateKPIsMenu();
    }

    else {
        return SUPMenu();
      
    }

};

  function Emplogin() returns string|error {
string UserId = io:readln("Enter EmpID...");
string Name = io:readln("Enter User Username...");
string password = io:readln("Enter User Password...");

HOD theEmployee = { 
                          emp_id:  UserId,
                          EMPname : Name,
                          password: password
                  
    ,HODname: "", HOD_id: ""};

        // string addedUser = check ep->createUser(theUser);
         io:println("Employee Log in Sucessful ");

        string input=io:readln("\n\nEnter (1) to continue to Employee Menu ");

  }

  function EMPMenu() returns string|error {

   io:println("-----What would you like to do -----");

    io:println("\n\n1)Create KPI");

string input = io:readln("\n\nPlease Pick an option: ");


    if (input == "1") {
          return CreateKPIMenu();
    }

    else {
        return EMPMenu();
      
    }
    
    
  }
function addDepObjMenu() returns string|error {}
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
function deleteObjMenu() returns string|error {}
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
    function CreateKPIMenu() returns string|error {}
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

function DeleteKIPMenu() returns string|error {}
public function deleteKPI(graphql:Client graphqlClient, KPI kpi) returns error? {
       
        string addDoc5 = string `
        mutation deleteKPI($KPIname:String!,$KPI_id:String!){
        deleteKPI(newKPI:{KPI_id:$KPI_id,KPIname:$KPIname)  {
         KPI_id
         KPIname
         score
        }
    }`;
    string KPIname = io:readln("Enter KPI name:");
     Dev_ObjectivesResponse deleteKPI = check graphqlClient->execute(addDoc5, {"KPIname":KPIname});
    io:println("Response ", deleteKPI);
        string exitSys = io:readln("Press 0 to go back");

        if (exitSys === "0") {
            error? rerun = main();
            if rerun is error {
                io:println("Error, You can't go back to options page.");
            }
        
     }
    }
    function UpdateKPIsMenu() returns string|error {}
    public function updateKPI(graphql:Client graphqlClient, KPI kpi) returns error? {
    string updateDoc = string`
        mutation updateKPI($KPI_id: String!, $KPIname: String, $score: Int) {
            updateKPI(KPI_id: $KPI_id, newKPI: { KPIname: $KPIname, score: $score }) {
                KPI_id
                KPIname
                score
            }
        }`;

    string KPI_id = io:readln("Enter KPI Id:");
    string KPIname = io:readln("Enter KPI name:");
    string score = io:readln("Enter score");

    // You may also prompt for new values for KPI name and score.

    // Create a map of variables with the values to be updated.
    map<string> updateVariables = {
        "KPI_id": KPI_id,
        "KPIname": KPIname,
        "score": score
    };

    Dev_ObjectivesResponse updateDev_Objectives = check graphqlClient->execute(updateDoc, updateVariables);

    io:println("Response: ", updateDev_Objectives);

    string exitSys = io:readln("Press 0 to go back");

    if (exitSys === "0") {
        error? rerun = main();
        if rerun is error {
            io:println("Error, You can't go back to options page.");
        }
    }
}

