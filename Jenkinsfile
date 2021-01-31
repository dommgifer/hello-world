node {
    docker.withRegistry('https://10.40.1.175', 'registry') {
        def project = 'hello-world'
        def appName = 'hello'
        def tag = "v_${env.BUILD_NUMBER}"
        def img = "${appName}-${env.BRANCH_NAME}"
        def imgWithTag = "${img}:${tag}"
        def deployimage = "10.40.1.175/pipeline/${imgWithTag}"
        
        checkout scm

        stage '建立映像檔'
        sh("docker build -t ${imgWithTag} .")
        sh("docker tag ${imgWithTag} 10.40.1.175/pipeline/${imgWithTag}")

        stage '放置映像檔'
        sh("docker push 10.40.1.175/pipeline/${imgWithTag} ")

        stage '部署'
        container('jenkins-slave-kubectl'){
            sh("sed -i 's#IMAGE_NAME#${deployimage}#' deployment.yaml")
            sh('kubectl apply -f deployment.yaml -n jenkins')
        }
    }
}
