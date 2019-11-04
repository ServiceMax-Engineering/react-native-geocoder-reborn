node('nodejs') {

    def skipBuildFromCommit = false
    try {
        stage('Checkout') {
            timeout(time: 30, unit: 'MINUTES') {
                checkout scm
                commitMessage = sh returnStdout: true, script: "git log --pretty=format:'%h - %s <%an>' -1"
                skipBuildFromCommit = commitMessage.contains("[skip ci]")
                echo commitMessage
            }
        }

        if (skipBuildFromCommit) {
            echo "Build skipped!"
            currentBuild.result = 'SUCCESS'
            currentBuild.description = "Build skipped!"
            return
        }

        stage('Install Dependencies') {
            sh './jenkins.sh install'
        }

        stage('Lint') {
            //timeout after 20 minutes in Test stage
            timeout(time: 20, unit: 'MINUTES') {
                print "Lint is NOT yet implemented!"
                //sh './jenkins.sh flow'
                // sh './jenkins.sh lint:report'

                // try {
                //     publishHTML (target: [
                //         allowMissing: true,
                //         alwaysLinkToLastBuild: false,
                //         keepAll: true,
                //         reportDir: 'lint',
                //         reportFiles: 'eslint.html',
                //         reportName: 'ESLint HTML Report'
                //     ])
                // } catch (all) {
                //     error 'Failed collect ESLint report'
                // }
                // try {
                //     step([
                //         $class: 'CheckStylePublisher',
                //         canComputeNew: false,
                //         defaultEncoding: '',
                //         healthy: '',
                //         pattern: 'lint/eslint.xml',
                //         unHealthy: ''
                //     ])

                //     // Violation comments on Pull Requests only!!!
                //     if( env.BRANCH_NAME.startsWith("PR-") ) {
                //         def PR_ID = env.BRANCH_NAME.substring(3);

                //         withCredentials([usernamePassword(
                //             // Username/Personal Access Token credentials should exist under this ID.
                //             credentialsId: '9984dda4-0c5d-4a9b-a3cb-c8acb4f0c2c6',
                //             passwordVariable: 'GITHUB_TOKEN',
                //             usernameVariable: 'GITHUB_USERNAME')
                //         ]) {
                //             // Report checkstyle issues on Github
                //             // Requires https://wiki.jenkins-ci.org/display/JENKINS/Violation+Comments+to+GitHub+Plugin
                //             step([
                //                 $class: 'ViolationsToGitHubRecorder',
                //                 config: [
                //                     gitHubUrl: 'https://api.github.com/',
                //                     repositoryOwner: 'ServiceMax-Engineering',
                //                     repositoryName: 'sfm-engine',
                //                     pullRequestId: PR_ID,
                //                     createSingleFileComments: true,
                //                     useOAuth2Token: true,
                //                     oAuth2Token: env.GITHUB_TOKEN,
                //                     minSeverity: 'ERROR',
                //                     violationConfigs: [
                //                         [ pattern: '.*/lint/eslint\\.xml$', reporter: 'CHECKSTYLE' ],
                //                     ]
                //                 ]
                //             ])
                //         }
                //     }
                // } catch (all) {
                //     error 'Failed to collect checkstyle report'
                // }
            }
        }

        stage('Test') {
            timeout(time: 30, unit: 'MINUTES') {

                print "Test is NOT yet implemented!"
                // sh './jenkins.sh test'
                // // Archive coverage results
                // // Requires the HTML Publisher Plugin (https://wiki.jenkins-ci.org/display/JENKINS/HTML+Publisher+Plugin)
                // try {
                //     publishHTML (target: [
                //         allowMissing: true,
                //         alwaysLinkToLastBuild: false,
                //         keepAll: true,
                //         reportDir: 'coverage',
                //         reportFiles: 'lcov-report/index.html',
                //         reportName: 'Coverage Report'
                //     ])
                // } catch (all) {
                //     error 'Coverage report collection failed'
                // }
            }
        }

        stage('Build') {
            timeout(time: 30, unit: 'MINUTES') {
                print "Build is NOT yet implemented!"
                // sh './jenkins.sh build'
            }
        }

        stage('Relase') {
            timeout(time: 30, unit: 'MINUTES') {
                withCredentials([
                    // Username/Personal Access Token credentials should exist under this ID.
                    usernamePassword(
                        credentialsId: 'GITHUB_USER_TOKEN',
                        passwordVariable: 'GITHUB_TOKEN',
                        usernameVariable: 'GITHUB_USERNAME'),
                    // Username/Personal Access Token credentials should exist under this ID.
                    usernamePassword(
                        credentialsId: 'NPM_USER_PASSWORD',
                        passwordVariable: 'NPM_PASSWORD',
                        usernameVariable: 'NPM_USERNAME')
                ]) {
                    // sh 'npm run build'
                    if (env.BRANCH_NAME == 'master' || env.BRANCH_NAME.startsWith('release')) {
                        sh 'export ghprbTargetBranch=${CHANGE_TARGET}; ./jenkins.sh semantic-release'
                    }
                    else {
                        sh 'export ghprbTargetBranch=${CHANGE_TARGET}; ./jenkins.sh semantic-release-dry-run'
                    }
                }
            }
        }

        currentBuild.result = 'SUCCESS'

    } catch (all) {
        currentBuild.result = 'FAILURE'
    }

    // Clean up workspace
    step([$class: 'WsCleanup'])
}
