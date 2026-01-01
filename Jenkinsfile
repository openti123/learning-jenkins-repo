pipeline {
    agent any
       parameters {
        string(name: 'PERSON', defaultValue: 'Kwadwo Openti', description: 'Name of person')

        choice(name: 'age', choices: [23, 30, 40], description: 'age choices')

      
    }

    stages {
        stage("Hello-1st stage") {
            steps {
                echo "Hello World - ${params.PERSON}-- upadte with more information"
                
               
            }
            
        }
        
        stage('Hello-2nd stage') {
            steps {
                echo "Hello World- ${params.PERSON} stage more infor for myself"
                
            }
        }
        stage('Hello-3rd stage') {
            steps {
                echo "Hello World - ${params.age} of chef infomration"
            }
        }
    }
}