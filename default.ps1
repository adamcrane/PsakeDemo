Framework "4.6"

properties {
	$buildFile = resolve-path ".\PsakeDemo.sln"
	$vstestpath = "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe"
	$environment = $env
	$testPackage = $tests
}

FormatTaskName "-------------------- {0} --------------------"

Task default -Depends Build

Task Build {
	"Building $environment"
    msbuild $buildFileName /t:Build /p:Configuration=Debug /v:minimal
}
# psake Build -parameters "@{'env'='dev'}"
Task Test -Depends Build {
	"Testing $testPackage"
	& $vstestpath PsakeDemo.Tests\bin\Debug\PsakeDemo.Tests.dll
}
# psake Test -parameters "@{'env'='dev';'tests'='Acceptance'}"

Task Clean {
	msbuild $buildFileName /t:Clean
}

Task Deploy -Depends Build -precondition { return $env }{
	"Deploying $environment"
}

Task FailureTask {
	#use cmd.exe and the DOS exit() function to simulate a failed command-line execution
	"Executing command-line program"
	cmd /c exit (1) 
	CheckForError("Failure Task")
}

function CheckForError($task) {
  if ($lastexitcode -ne 0)
  {
    throw "$task failed"
  }
}