import ballerinax/mongodb;
import ballerina/graphql;
import ballerina/log;
import ballerina/io;


type HOD record {
    string HOD_id;
    string HODname;
    string? password;
};

type Supervisor record{
    string supID;
    string SUPname;
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
type updateKPI record{
    string KPIname;
    string KPI_id;
    int score;

};
type Dep_Objectives record{
    string Obj_id;
    string Obj_name;
    string HOD_id;
};
type UserDetails record {
    string username;
    string? password;
    boolean isHOD;
    boolean isSup;
    boolean isEMP;
};
type AddEmpDetails record {
    string username;
    string? password;
    string supID;
};
type LoggedHODDetails record {
    string username;
    boolean isHOD;
};
type LoggedSupDetails record {
    string username;
    boolean isSup;
};
type LoggedEmpDetails record {
    string username;
    boolean isEMP;
};
type KPIdetails record {
   string KPIname; 
   int score;
   string grade;
};
type UpdatedKPIDetails record {
    string KPIname; 
    int score;
    string grade;
};
type EmployeeScore record {
    string supID;
    string emp_id;
    int score;

};
type AssignedEmployee record {
    string EMPname;
    string emp_id;
    string supID;

};
type EmploginInput record {
    string EMPname ;
    string password ;
};
type GetEmpScoreInput record {
    string supID ;
    int score ;
};

mongodb:ConnectionConfig mongoConfig = {
    connection: {
        host: "localhost",
        port: 27017,
        auth: {
            username:"",
            password: ""
        },
        options: {
            sslEnabled: false, 
            serverSelectionTimeout: 5000
        }
    },
    databaseName: "EmployeeManagementSystem"
};
mongodb:Client mongoClient = check new (mongoConfig);
configurable string HOD_Collection = "HOD" ;
configurable string KPI_Collection = "KPIs" ;
configurable string Objectives_Collection = "Objectives" ;
configurable string Employee_Collection = "Employee";
configurable string Supervisor_Collection = "Supervisor";
configurable string databaseName = "EmployeeManagementSystem";


@graphql:ServiceConfig {
    graphiql: {
        enabled: true
    // Path is optional, if not provided, it will be dafulted to `/graphiql`.
    //path: ""
    }
}

service / on new graphql:Listener(9090){

//HOD functions
//function to add/create new department objectives
    remote function addDepObjectives(Dep_Objectives newObjective) returns error|string {
        map<json> doc = <map<json>> newObjective.toJson();
        _ = check mongoClient->insert(doc, Objectives_Collection, "");
        return newObjective.Obj_name + " added successfully";
    }
    
    //function to delete department objectives
    remote function deleteDepObjectives(string Obj_name) returns error|string {
        mongodb:Error|int deleteObject = mongoClient->delete(Objectives_Collection, "", {name: Obj_name},false);
        if deleteObject is mongodb:Error{
            return error("Failed to delete objective");
        }else {
            if deleteObject > 0{
                return  "Objective successfully deleted";
            }else{
              return string `Objective not found`; 
            }
        }
    }

    //function to view total scores of employees
    resource function get getTotalScores () returns Employee[]| error {
      var totalScores = check mongoClient->find(Employee_Collection,"",{}, {}, {}, -1, -1, []);

      log:printInfo(totalScores.toBalString());
        return [];
    }

      remote function deleteKPI(string KPIname) returns error|string {
        mongodb:Error|int deleteKPI = mongoClient->delete(KPI_Collection, "", {name: KPIname},false);
        if deleteKPI is mongodb:Error{
            return error("Failed to delete KPI");
        }else {
            if deleteKPI > 0{
                return " KPI successfully deleted";
            }else{
              return string `KPI not found`; 
            }
        }
    }

    remote function addKPI(KPI newKPI) returns error|string {
        if (newKPI.isValid) {
        map<json> doc = <map<json>> newKPI.toJson();
        _ = check mongoClient->insert(doc, KPI_Collection, "");
        return newKPI.KPIname + "added successfully";
     }else{
        return error("Invalid KPI. It cannot be added.");
     }
    }

    remote function gradeKPI(KPI kpi) returns string | error {
        // Add your grading logic here
        if (kpi.score >= 0 && kpi.score <= 100) {
            if (kpi.score >= 0 && kpi.score < 20) {
                kpi.grade = "Grade 1";
            } else if (kpi.score >= 20 && kpi.score < 40) {
                kpi.grade = "Grade 2";
            } else if (kpi.score >= 40 && kpi.score < 60) {
                kpi.grade = "Grade 3";
            } else if (kpi.score >= 60 && kpi.score < 80) {
                kpi.grade = "Grade 4";
            } else {
                kpi.grade = "Grade 5";
            }
            // Store the graded KPI in the collection
            map<json> doc = <map<json>> kpi.toJson();
            error? insertResult = mongoClient->insert(doc, KPI_Collection, "");
            if (insertResult is error) {
                return error("Failed to store graded KPI");
            }
            return string `KPI score is stored`;
        } else {
            return error("Invalid score. Please enter a score between 0 and 100.");
        }
    }

     resource function get getScore (KPI kpi) returns string[]| error {
      var score = check mongoClient->find(KPI_Collection,"",{KPIname:kpi.KPIname, score:kpi.score, grade:kpi.grade}, {}, {}, -1, -1, []);

      log:printInfo(score.toBalString());
        return [];

    }
    remote function addHOD(HOD newHOD) returns error|string {
        map<json> doc = <map<json>> newHOD.toJson();
        _ = check mongoClient->insert(doc, HOD_Collection, "");
        return newHOD.HODname + "added successfully";
          }

          remote function addSupervisor(Supervisor newSup) returns error|string {
        map<json> doc = <map<json>> newSup.toJson();
        _ = check mongoClient->insert(doc, Supervisor_Collection, "");
        return newSup.SUPname + "added successfully";
          }

          remote function addEmployee(AddEmpDetails newEMP) returns error|string {
        map<json> doc = <map<json>> newEMP.toJson();
        _ = check mongoClient->insert(doc, Employee_Collection, "");
        return newEMP.username + "added successfully";
          }
     resource function get HODlogin(HOD userHOD) returns LoggedHODDetails|error {
     stream<UserDetails, error?> usersDetails = check mongoClient->find(HOD_Collection, "", {username: userHOD.HODname, password: userHOD.password}, {});
 
     UserDetails[] users = check from var userInfo in usersDetails
        select userInfo;
     io:println("Users ", users);

    // If the user is found, return a user with isHOD field.
     if users.length() > 0 {
        return {username: users[0].username, isHOD: users[0].isHOD};
     }

    // If user is not found, return a default object.
     return {username: "", isHOD: false};
    }

    resource function get Suplogin(Supervisor userSup) returns LoggedSupDetails|error {
     stream<UserDetails, error?> usersDetails = check mongoClient->find(Supervisor_Collection, "", {username: userSup.SUPname, password: userSup.password}, {});
 
     UserDetails[] users = check from var userInfo in usersDetails
        select userInfo;
     io:println("Users ", users);

    // If the user is found, return a user with isHOD field.
     if users.length() > 0 {
        return {username: users[0].username, isSup: users[0].isSup};
     }

    // If user is not found, return a default object.
     return {username: "", isSup: false};
    }

    resource function get Emplogin(EmploginInput userEmp) returns LoggedEmpDetails|error {
     stream<UserDetails, error?> usersDetails = check mongoClient->find(Employee_Collection, "", {username: userEmp.EMPname, password: userEmp.password}, {});
 
     UserDetails[] users = check from var userInfo in usersDetails
        select userInfo;
     io:println("Users ", users);

    // If the user is found, return a user with isHOD field.
     if users.length() > 0 {
        return {username: users[0].username, isEMP: users[0].isEMP};
     }

    // If user is not found, return a default object.
     return {username: "", isEMP: false};
    }

     remote function changeKPI(UpdatedKPIDetails updatedKPI) returns error|string {

        map<json> newKPIDoc = <map<json>>{"$set": {"KPIname": updatedKPI.KPIname, "score": updatedKPI.score, "grade": updatedKPI.grade}};

        int updatedCount = check mongoClient->update(newKPIDoc, KPI_Collection, "", {KPIname: updatedKPI.KPIname, score: updatedKPI.score, grade: updatedKPI.grade}, true, true);
        io:println("Updated Count ", updatedCount);

        if updatedCount > 0 {
           return "KPI successfully updated: ";
        }
        return "Failed to updated";
    }

    //  resource function get getEmpScore (string supID, string empID) returns Employee[]| error {
    //   var empScore = check mongoClient->find(Employee_Collection,"",{}, {}, {}, -1, -1, []);

    //   log:printInfo(empScore.toBalString());
    //     return [];
    // }

    resource function get getEmpScore(GetEmpScoreInput userEMP) returns EmployeeScore|error {
     stream<EmployeeScore, error?> employee_score = check mongoClient->find(Employee_Collection, "", {supID: userEMP.supID, score: userEMP.score}, {});
 
     EmployeeScore[] users = check from var userInfo in employee_score
        select userInfo;
     io:println("Users ", users);

     if users.length() > 0 {
        return users[0];  //Returns the first matching Assigned Employee
    }

    return error("User not found");
    }

}