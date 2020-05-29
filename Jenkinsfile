node('jenkins-slave') {
    def newApp
    def registry = 'kumargaurav522/docker-test'
    def registryCredential = 'dockerhub'
	
	    
        stage('Checkout SCM') {
                echo '> Checking out the source control ...'
                checkout scm
        }
//	stage('Git') {
//		git 'https://github.com/kumargaurav522/node-pileline-script.git'
//	}
	
	stage('Building image') {
        def buildName = registry + ":$BUILD_NUMBER"
		newApp = docker.build buildName
	}
    
    stage('Test inside container code'){
		newApp.inside('-p 8080') {
		  container('nodejs') { 
		        script {
		 sh script: 'npm install'
		 sh script: 'nohup node server.js &'
          BUILD_FULL = sh(script: 'curl -w %{http_code} -s --output /dev/null http://0.0.0.0:8080', returnStatus: true)== 0
         if ( BUILD_FULL != true ){
                    println 'Error: Validation failed!! App is not start inside container' 
                        } else {
                            println 'App Working fine inside container'
                        }
                    }
		       }
		    }
		  script {
		  if ( BUILD_FULL != true ){
		       sh "docker rmi $registry:$BUILD_NUMBER"
		       error 'Error: Validation failed!! App is not start inside container'
		        }
		  }  
    }
        
	stage('Push Image') {
	    docker.withRegistry( '', registryCredential ) {
	        newApp.push()
	    }
	}
	
    stage('Removing image') {
        sh "docker rmi $registry:$BUILD_NUMBER"
       
    }
    
    stage('Deploy on K8s Cluster') {
        container('kubectl') {
         // sh 'kubectl -n group1 --dry-run=server apply -f $WORKSPACE/deployment.yaml'
        sh ('sed -i -e "s|image: .*|image: kumargaurav522/docker-test:${BUILD_NUMBER}|g" $WORKSPACE/deployment-latest.yaml')
        sh ('kubectl -n product apply -f $WORKSPACE/deployment-latest.yaml')
         
         }
        }
    }
