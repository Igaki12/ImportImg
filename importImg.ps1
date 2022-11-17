$addingPhrase = ""
  #検索ファイルの拡張子縛りを廃止した。変な挙動をする場合は$answerFiles = Get-ChildItem -Path "./src/img/answer/*.png" -Name　へ戻す
$answerFiles = Get-ChildItem -Path "./src/img/answer/*" -Name
$questionFiles = Get-ChildItem -Path "./src/img/question/*" -Name
$questionList = Get-Content -Path ".\src\useQuestionList.js"

 # powershell -NoProfile -ExecutionPolicy Unrestricted ../importImg.ps1   で一発。
 Write-Host("imporImg.ps1:足りない文章を表示します")


foreach($f in $questionFiles){
  #if($questionList -notcontains "import",$f.Substring(0,$f.Length - 4),"from './img/question/$f'"){
  if($questionList -notcontains "import",[IO.Path]::GetFileNameWithoutExtension($f) ,"from './img/question/$f'"){
    Write-Host("import",$f.Substring(0,$f.Length - 4),"from './img/question/$f'")
    $addingPhrase = " import",[IO.Path]::GetFileNameWithoutExtension($f),"from './img/question/$f'; " + $addingPhrase
  }
}

foreach($f in $answerFiles){
 # Write-Host($f)
 # Write-Host($f.Substring(0,$f.Length - 4))
 # Write-Host("import",$f.Substring(0,$f.Length - 4),"from './img/answer/$f'")

  # if($questionList -notcontains "import",$f.Substring(0,$f.Length - 4),"from './img/answer/$f'"){
   if($questionList -notcontains "import",[IO.Path]::GetFileNameWithoutExtension($f),"from './img/answer/$f'"){
    Write-Host("import",$f.Substring(0,$f.Length - 4),"from './img/answer/$f'")
    $addingPhrase = " import",[IO.Path]::GetFileNameWithoutExtension($f),"from './img/answer/$f'; " + "$addingPhrase"
  }
}
 # $newQuestionList = $addingPhrase + $questionList
 # Clear-Content ".\src\useQuestionList.js"
 # Write-Output $addingPhrase | Add-Content ".\src\useQuestionList.js" -Encoding default
 # Write-Output $questionList | Add-Content ".\src\useQuestionList.js" -Encoding default

 # 本来自動でJSファイルに文字を追加するところまで自動化したかったが、エンコードの問題や改行の問題があり、手動で追加したほうが早いと結論。
 Write-Host($addingPhrase)
 "$addingPhrase" | Clip
Write-Host("FINISH SEARCHING!")

