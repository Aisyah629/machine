// JCL WORKFLOW ORCHESTRATOR TOOL
// This JCL script demonstrates a basic workflow consisting of two jobs.
// Job 1: Process Data
// Job 2: Generate Report

// Job 1: Process Data
// JCL statement to start the job
// JOB1: JOB
//     //JOB1 JOB CLASS=A,MSGCLASS=0
//     //STEP1 EXEC PGM=SORT
//     //SORTIN DD DSN=INPUT.DATA,DISP=SHR
//     //SORTOUT DD DSN=OUTPUT.DATA,DISP=(NEW,CATLG,DELETE),
//     //             UNIT=SYSDA,SPACE=(CYL,(10,5))
//     //SYSPRINT DD SYSOUT=A
//     //SYSIN DD *
//         SORT FIELDS=(1,10,CH,A)
// /*
//     //END
//     //JOB1 ENDCARD

// Job 2: Generate Report
// JCL statement to start the job
// JOB2: JOB
//     //JOB2 JOB CLASS=A,MSGCLASS=0
//     //STEP1 EXEC PGM=IEFBR14
//     //REPORT DD DSN=REPORT.DATA,DISP=(NEW,CATLG,DELETE),
//     //             UNIT=SYSDA,SPACE=(CYL,(5,2))
//     //SYSPRINT DD SYSOUT=A
//     //END
//     //JOB2 ENDCARD
