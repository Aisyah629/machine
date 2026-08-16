/* JCL BATCH ORCHESTRATOR TOOL - MAIN EXECUTION SCRIPT */
/* ARCHITECTS A MAINFRAME JOB CONTROL SYSTEM WITH CONDITIONAL */
/* STEP ROUTING, RESOURCE ALLOCATION PROTOCOLS, AND LEGACY */
/* DATASET MANAGEMENT. BUILT STRICTLY IN JCL. */

//JCLORCH JOB CLASS=A,MSGCLASS=X,NOTIFY=&SYSUID,
//         REGION=0M,TIME=1440
//JCLLIB ORDER=(SYS1.JCLLIB,USER.JCLLIB)
//IEFJCL  DD DSN=SYS1.PROCLIB,DISP=SHR

/* ----------------------------------------------------------- */
/* STEP 1: PRE-PROCESSING & RESOURCE INITIALIZATION            */
/* ----------------------------------------------------------- */
//PREPROC  EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=A
//SYSIN    DD  *
   DEFINE CLUSTER (NAME(SYS1.ORBSTR.META) -
                  TRACKS(10,5) -
                  REUSE -
                  NONINDEXED -
                  SHAREOPTIONS(3))
/* ----------------------------------------------------------- */
/* STEP 2: DATASET VALIDATION & CONDITIONAL ROUTING SETUP      */
/* ----------------------------------------------------------- */
//DVLDCHK  EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=A
//INFILE   DD  DSN=SYS1.ORBSTR.INPUT,DISP=SHR
//SYSIN    DD  *
   LISTCAT LEVEL(SYS1.ORBSTR)
/* ----------------------------------------------------------- */
/* STEP 3: MAIN ORCHESTRATION LOGIC (RESOURCE ALLOCATION)      */
/* ----------------------------------------------------------- */
//ORCBATCH EXEC PGM=IEFBR14
//ALLOCDD  DD  DSN=SYS1.ORBSTR.ALLOC.REC,DISP=(NEW,CATLG,DELETE),
//         SPACE=(CYL,(5,2),RLSE),UNIT=SYSDA
//SORTDD   DD  DSN=SYS1.ORBSTR.SORT.WORK,DISP=(NEW,CATLG,DELETE),
//         SPACE=(TRK,(10,5),RLSE),UNIT=SYSDA
/* ----------------------------------------------------------- */
/* STEP 4: CONDITIONAL EXECUTION & STEP ROUTING                */
/* ----------------------------------------------------------- */
//CONDROU  EXEC PGM=IEBGENER
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  DSN=SYS1.ORBSTR.INPUT,DISP=SHR
//SYSUT2   DD  DSN=SYS1.ORBSTR.OUTPUT,DISP=(OLD,DELETE),
//         DCB=(BLKSIZE=6160)
//SYSIN    DD  DUMMY
/* ----------------------------------------------------------- */
/* STEP 5: CLEANUP & SPOOLED REPORTING                         */
/* ----------------------------------------------------------- */
//CLRUP    EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=A
//SYSIN    DD  *
   DELETE SYS1.ORBSTR.ALLOC.REC PURGE
   DELETE SYS1.ORBSTR.SORT.WORK PURGE
/* ----------------------------------------------------------- */
/* END OF JOB ORCHESTRATOR                                     */
/* ----------------------------------------------------------- */
