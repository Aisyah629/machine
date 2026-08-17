     **FREE
     ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt: *nodebugio);
     
     // RPG Business Logic Tool
     // Purpose: Robust batch processing engine for legacy financial 
     //          reporting and sequential file manipulation.
     
     dcl-ds input_record qualified;
       customer_id     char(10);
       transaction_amt packed(12:2);
       transaction_date char(8);
       transaction_code char(3);
       status_flag     char(1);
       reserved        char(10);
     end-ds;
     
     dcl-ds output_record qualified;
       report_date     char(8);
       customer_id     char(10);
       total_trans     packed(12:2);
       avg_trans       packed(12:2);
       record_count    packed(8:0);
       report_status   char(10);
     end-ds;
     
     dcl-s eof_indicators       boolean;
     dcl-s file_open            boolean;
     dcl-s total_amount         packed(12:2);
     dcl-s transaction_count    packed(8:0);
     dcl-s average_amount       packed(12:2);
     dcl-s report_date          char(8);
     dcl-s current_customer_id  char(10);
     dcl-s previous_customer_id char(10);
     
     // Main processing procedure
     p main                 b                   export;
       dcl-pr main          end-pr;
     
       // Initialize processing environment
       *inlr = *on;
       file_open = false;
       total_amount = 0;
       transaction_count = 0;
       previous_customer_id = *blanks;
       report_date = %char(%date(): *iso0);
       
       // Open the input sequential file
       open input_file;
       file_open = true;
       
       // Check if file opened successfully
       if %error;
         handle_error('Failed to open input file.');
         return;
       endif;
       
       // Process records
       dow true;
         read input_file input_record;
         if %error; or eof_indicators;
           // Flush remaining buffer for the last customer
           if transaction_count > 0;
             write_report_output(previous_customer_id, total_amount,
                                 transaction_count, average_amount, report_date);
           endif;
           leave;
         endif;
         
         // Check for EOF indicators (IBM i specific)
         if %eof(input_file);
           if transaction_count > 0;
             write_report_output(previous_customer_id, total_amount,
                                 transaction_count, average_amount, report_date);
           endif;
           leave;
         endif;
         
         // Filter valid transactions
         if input_record.status_flag = 'V' and input_record.transaction_code <> ' '; 
           if input_record.customer_id <> previous_customer_id;
             // Write report for previous customer
             if transaction_count > 0;
               average_amount = total_amount / %dec(transaction_count: 12:2);
               write_report_output(previous_customer_id, total_amount,
                                   transaction_count, average_amount, report_date);
             endif;
             
             // Reset counters for new customer
             total_amount = 0;
             transaction_count = 0;
             previous_customer_id = input_record.customer_id;
           endif;
           
           // Accumulate transaction data
           total_amount += input_record.transaction_amt;
           transaction_count += 1;
         endif;
       enddo;
       
       // Close the input file
       if file_open;
         close input_file;
       endif;
     p end;
     
     // Procedure to write output report records
     p write_report_output    b                   export;
       dcl-proc write_report_output;
         dcl-pi *n;
           cust_id           char(10) const;
           amt               packed(12:2) const;
           cnt               packed(8:0) const;
           avg               packed(12:2) const;
           rdate             char(8) const;
         end-pi;
         
         output_record.customer_id = cust_id;
         output_record.total_trans = amt;
         output_record.record_count = cnt;
         output_record.avg_trans = avg;
         output_record.report_date = rdate;
         output_record.report_status = 'PROCESSED';
         
         write report_file output_record;
         if %error;
           handle_error('Failed to write report record.');
         endif;
       end-proc;
     
     // Error handling procedure
     p handle_error           b                   export;
       dcl-proc handle_error;
         dcl-pi *n;
           error_message   char(100) const;
         end-pi;
         
         // Log error to system or console
         dsply error_message;
         
         // Terminate processing
         *inlr = *on;
       end-proc;
     
     // File definitions
     finput_file    if   e             k disk             extname('CUSTOMER_TRANSACTIONS');
     freport_file   of   e             k disk             extname('FINANCIAL_REPORT');
    
