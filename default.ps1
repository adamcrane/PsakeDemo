Framework "4.6"

properties {
	$buildFile = resolve-path ".\PsakeDemo.sln"
	$vstestpath = "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe"
}

FormatTaskName "-------------------- {0} --------------------"

Task default -Depends Build

Task Build {
    msbuild $buildFileName /t:Build /p:Configuration=Debug /v:minimal
}

Task Test -Depends Build {
	& $vstestpath PsakeDemo.Tests\bin\Debug\PsakeDemo.Tests.dll
}

Task Clean {
	msbuild $buildFileName /t:Clean
}