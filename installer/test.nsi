Name "Multiple InstFiles"
OutFile "multi-install.exe"

!include MUI.nsh
!include Sections.nsh

##===========================================================================
## Modern UI Pages
##===========================================================================

!insertmacro MUI_PAGE_WELCOME

!define MUI_PAGE_CUSTOMFUNCTION_PRE SelectFilesCheck
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE ComponentsLeave
!insertmacro MUI_PAGE_COMPONENTS

## This is the title on the first Directory page
!define MUI_DIRECTORYPAGE_TEXT_TOP "$(MUI_DIRECTORYPAGE_TEXT_TOP_A)"

!define MUI_PAGE_CUSTOMFUNCTION_PRE SelectFilesA
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

## This is the title on the second Directory page
!define MUI_DIRECTORYPAGE_TEXT_TOP "$(MUI_DIRECTORYPAGE_TEXT_TOP_B)"

!define MUI_PAGE_CUSTOMFUNCTION_PRE SelectFilesB
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

!define MUI_PAGE_CUSTOMFUNCTION_LEAVE DeleteSectionsINI
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

##===========================================================================
## Language strings
##===========================================================================

LangString NoSectionsSelected ${LANG_ENGLSH} "You haven't selected any sections!"

LangString MUI_DIRECTORYPAGE_TEXT_TOP_A ${LANG_ENGLSH} "Setup will install \
Program #1 in the following folder..."
LangString MUI_DIRECTORYPAGE_TEXT_TOP_B ${LANG_ENGLSH} "Setup will install \
Program #2 in the following folder..."

##===========================================================================
## Start sections
##===========================================================================

## Sections Group 1
SectionGroup /e "Program #1" PROG1
Section "Main" SEC1
 ##All the files in Group 1 will be installed to the same location, $INSTDIR
 SetOutPath "$INSTDIR"
 ## Main files to install here

SectionEnd

Section "Other" SEC2
 ## Other files to install here

SectionEnd

SectionGroupEnd

## Sections Group 2
SectionGroup /e "Program #2" PROG2

Section "Main" SEC3
 ##All the files in Group 2 will be installed to the same location, $INSTDIR
 SetOutPath "$INSTDIR"
 ## Main files to install here

SectionEnd

Section "Other" SEC4
 ## Other files to install here

SectionEnd

SectionGroupEnd

##===========================================================================
## Settings
##===========================================================================

!define PROG1_InstDir    "C:\PROG1"
!define PROG1_StartIndex ${PROG1}
!define PROG1_EndIndex   ${SEC2}

!define PROG2_InstDir "C:\PROG2"
!define PROG2_StartIndex ${PROG2}
!define PROG2_EndIndex   ${SEC4}

##===========================================================================
## Please don't modify below here unless you're a NSIS 'wiz-kid'
##===========================================================================

## Create $PLUGINSDIR
Function .onInit
 InitPluginsDir
FunctionEnd

## If user goes back to this page from 1st Directory page
## we need to put the sections back to how they were before
Var IfBack
Function SelectFilesCheck
 StrCmp $IfBack 1 0 NoCheck
  Call ResetFiles
 NoCheck:
FunctionEnd

## Also if no sections are selected, warn the user!
Function ComponentsLeave
Push $R0
Push $R1

 Call IsPROG1Selected
  Pop $R0
 Call IsPROG2Selected
  Pop $R1
 StrCmp $R0 1 End
 StrCmp $R1 1 End
  Pop $R1
  Pop $R0
 MessageBox MB_OK|MB_ICONEXCLAMATION "$(NoSectionsSelected)"
 Abort

End:
Pop $R1
Pop $R0
FunctionEnd

Function IsPROG1Selected
Push $R0
Push $R1

 StrCpy $R0 ${PROG1_StartIndex} # Group 1 start

  Loop:
   IntOp $R0 $R0 + 1
   SectionGetFlags $R0 $R1          # Get section flags
    IntOp $R1 $R1 & ${SF_SELECTED}
    StrCmp $R1 ${SF_SELECTED} 0 +3      # If section is selected, done
     StrCpy $R0 1
     Goto Done
    StrCmp $R0 ${PROG1_EndIndex} 0 Loop

 Done:
Pop $R1
Exch $R0
FunctionEnd

Function IsPROG2Selected
Push $R0
Push $R1

 StrCpy $R0 ${PROG2_StartIndex}    # Group 2 start

  Loop:
   IntOp $R0 $R0 + 1
   SectionGetFlags $R0 $R1          # Get section flags
    IntOp $R1 $R1 & ${SF_SELECTED}
    StrCmp $R1 ${SF_SELECTED} 0 +3      # If section is selected, done
     StrCpy $R0 1
     Goto Done
    StrCmp $R0 ${PROG2_EndIndex} 0 Loop

 Done:
Pop $R1
Exch $R0
FunctionEnd

## Here we are selecting first sections to install
## by unselecting all the others!
Function SelectFilesA

 # If user clicks Back now, we will know to reselect Group 2's sections for
 # Components page
 StrCpy $IfBack 1

 # We need to save the state of the Group 2 Sections
 # for the next InstFiles page
Push $R0
Push $R1

 StrCpy $R0 ${PROG2_StartIndex} # Group 2 start

  Loop:
   IntOp $R0 $R0 + 1
   SectionGetFlags $R0 $R1                  # Get section flags
    WriteINIStr "$PLUGINSDIR\sections.ini" Sections $R0 $R1 # Save state
    !insertmacro UnselectSection $R0                # Then unselect it
    StrCmp $R0 ${PROG2_EndIndex} 0 Loop

 # Don't install prog 1?
 Call IsPROG1Selected
 Pop $R0
 StrCmp $R0 1 +4
  Pop $R1
  Pop $R0
  Abort

 # Set current $INSTDIR to PROG1_InstDir define
 StrCpy $INSTDIR "${PROG1_InstDir}"

Pop $R1
Pop $R0
FunctionEnd

## Here we need to unselect all Group 1 sections
## and then re-select those in Group 2 (that the user had selected on
## Components page)
Function SelectFilesB
Push $R0
Push $R1

 StrCpy $R0 ${PROG1_StartIndex}    # Group 1 start

  Loop:
   IntOp $R0 $R0 + 1
    !insertmacro UnselectSection $R0        # Unselect it
    StrCmp $R0 ${PROG1_EndIndex} 0 Loop

 Call ResetFiles

 # Don't install prog 2?
 Call IsPROG2Selected
 Pop $R0
 StrCmp $R0 1 +4
  Pop $R1
  Pop $R0
  Abort

 # Set current $INSTDIR to PROG2_InstDir define
 StrCpy $INSTDIR "${PROG2_InstDir}"

Pop $R1
Pop $R0
FunctionEnd

## This will set all sections to how they were on the components page
## originally
Function ResetFiles
Push $R0
Push $R1

 StrCpy $R0 ${PROG2_StartIndex}    # Group 2 start

  Loop:
   IntOp $R0 $R0 + 1
   ReadINIStr "$R1" "$PLUGINSDIR\sections.ini" Sections $R0 # Get sec flags
    SectionSetFlags $R0 $R1               # Re-set flags for this sec
    StrCmp $R0 ${PROG2_EndIndex} 0 Loop

Pop $R1
Pop $R0
FunctionEnd

## Here we are deleting the temp INI file at the end of installation
Function DeleteSectionsINI
 FlushINI "$PLUGINSDIR\Sections.ini"
 Delete "$PLUGINSDIR\Sections.ini"
FunctionEnd