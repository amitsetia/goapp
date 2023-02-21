podTemplate(yaml: '''
    apiVersion: v1
    kind: Pod
    spec:
      containers:
      - name: go
        image: golang:1.19.6-alpine3.17
        command:
        - sleep
        args:
        - 99d
      - name: kaniko
        image: gcr.io/kaniko-project/executor:debug
        command:
        - sleep
        args:
        - 9999999
        volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker
      restartPolicy: Never
      volumes:
      - name: kaniko-secret
        secret:
            secretName: dockercred
            items:
            - key: .dockerconfigjson
              path: config.json
''') {
  node(POD_LABEL) {
    stage('Get a GO project') {
      git url: 'https://github.com/amitsetia/goapp.git', branch: 'main'
    }

    stage('Build GO Image') {
      container('kaniko') {
        stage('Build a GO project') {
          sh '''
            /kaniko/executor --context `pwd` --destination setiaamit/go-app:0.1
          '''
        }
      }
    }

  }
}
