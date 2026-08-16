public aspect ExceptionMonitor {

    pointcut thrownExceptions():
        throwing(Exception);

    after() throwing(Exception ex):
        thrownExceptions() {
        String methodName = thisJoinPoint.getSignature().toShortString();
        System.out.println("[EXCEPTION] Method: " + methodName + " threw exception: " + ex.getMessage());
        ex.printStackTrace();
    }
}
