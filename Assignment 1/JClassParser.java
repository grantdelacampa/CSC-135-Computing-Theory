/*
* Grant De La Campa 
* 10/9/17
* CSC 135
* Recognizer for simple Java Class Grammar
* Sample grammers:
*     CBIV,SZ;PIM(IV)BF(V==9)TBV=8;ERV;EE$
*     CBIV,SZ;PSM(SZ)BF(V==9)TBV=8;ELBV=0;ERV;EE$
*     CBIV,SZ;PIM(IV)BW(V==0)TBV=9;Z=2;ERV;EE$
*     CBIV,SZ;PIM(IV)BV=8;RV;EE$
*/



import java.util.Scanner;
public class JClassParser {       
      static String inputString;     
      static int index = 0;     
      static int errorflag = 0; 
 
      private char token()      
      { return(inputString.charAt(index)); } 
 
      private void advancePtr()     
      { if (index < (inputString.length()-1)) index++; } 
 
      private void match(char T)     
      { if (T == token()) advancePtr(); else error(); } 
 
      private void error()     
      {       
         System.out.println("error at position: " + index);       
         errorflag = 1;       
         advancePtr();     
      }   
    //---------------------- 
    
      // <className>  B  < varlist> {<method>}   E 
      private void jClass()     
      {             
      
            className();            
            
            match('B');      
            varList();      
            while(token() == 'P') {       
                  method();      
            }     
            match('E');          
       }

       //C|D 
       private void className(){
         if (token() == 'C'){
            match ('C');
         }
         else if (token() == 'D'){
            match ('D');
         }
         else{
            error();
         }
       }
       
       // <vardef>{,<vardef>};
       private void varList(){
         varDef();
         match(',');
         while(token() == 'I' || token() == 'S'){
            varDef();
         };
         match(';');
       }

       // <type><var>
       private void varDef(){
         type();
         var();
       }
       
       // I|S
       private void type(){
         if (token() == 'I'){
            match ('I');
         }
         else if (token() == 'S'){
            match ('S');
         }
         else{
            error();
         }
       }
       
       //V|Z
       private void var(){
         switch(token()){
            case 'V': match('V'); break;
            case 'Z': match('Z'); break;
            default: error();
         }
       }
       
       // P <type> <mName> (<varDef> {,<vardef>}) B <stmnt> <returnstmnt> E
       private void method(){
         match('P');
         type();
         mName();
         match('(');
         varDef();
         while(token() == 'I' || token() == 'S'){
            match(',');
            varDef();
         }
         match(')');
         match('B');
         stmnt();
         returnStmnt();
         match('E');
       }

       // M|N
       private void mName(){
         switch(token()){
            case 'M': match('M'); break;
            case 'N': match('N'); break;
            default: error();
         }
       }
       
       //<ifstmnt>|<assignstmnt>|<whilestmnt>
       private void stmnt(){
         switch(token()){
            case 'F':;
               ifStmnt();
               break;
            case 'V':
               assignStmnt();
               break;
            case 'W':   
               whileStmnt();
               break;
            default:
               error();
               break;
            }
       }
       
       //F <cond> T B {<stmnt>} E [L B { <stmnt> } E]
       private void ifStmnt(){
         match('F');
         cond();
         match('T');
         match('B');
         while(token()== 'F' || token() == 'V' || token() == 'W'){
            stmnt();
            }
         match('E');
         if(token() == 'L'){
            match('L');
            match('B');
            while(token()== 'F' || token() == 'V' || token() == 'W'){
               stmnt();
            } 
            match('E');   
         }
         
       }
       
       //<var> = <digit>; 
       private void assignStmnt(){
            if (token() == 'V' || token() == 'Z'){ 
               var();
               }
           match('=');
            if(token() == '1' || token() == '2' || 
               token() == '3' || token() == '4' || 
               token() == '5' || token() == '6' ||
               token() == '7' || token() == '8' ||
               token() == '9' || token() =='0'){
               digit();
               }
            match(';');
         }
       
       // W <cond> T B <stmnt> {<stmnt>} E
       private void whileStmnt(){
       match('W');
       cond();
       match('T');
       match('B');
       while(token()== 'F' || token() == 'V' || token() == 'W'){
               stmnt();
            } 
       match('E');
       }
       
       //(<var> == <digit>)
       private void cond(){
         match('(');
         if(token() == 'V' || token() == 'Z'){
            var();
         }
         match('=');
         match('=');
         if(token() == '1' || token() == '2' || 
                    token() == '3' || token() == '4' || 
                    token() == '5' || token() == '6' ||
                    token() == '7' || token() == '8' ||
                    token() == '9' || token() =='0'){
               digit();
               }
         match(')');
       }
       
       //R <var>;
       private void returnStmnt(){
         match('R');
         var();
         match(';');
       }
       
       //1|2|3|4|5|6|7|8|9|0
       private void digit(){
         switch(token()){
            case '1': 
               match('1');
               break;
            case '2': 
               match('2');
               break;
            case '3': 
               match('3');
               break;
            case '4': 
               match('4');
               break;
            case '5': 
               match('5');
               break;
            case '6': 
               match('6');
               break;
            case '7': 
               match('7');
               break;
            case '8': 
               match('8');
               break;
            case '9': 
               match('9');
               break;
            case '0': 
               match('0');
               break;
            default:
               break;
         }
       }
       
       
 
// WRITE YOUR REST OF THE PARSER HERE 
//----------------------     
        private void start()     
        {       
            jClass();       
            match('$'); 
 
            if (errorflag == 0)         
               System.out.println("legal." + "\n");       
            else         
               System.out.println("errors found." + "\n");     
         }   
         //---------------------- 
    
         public static void main (String[] args)      
         {      
               JClassParser rec = new JClassParser(); 
 
            Scanner input = new Scanner(System.in); 
 
            System.out.print("\n" + "enter an expression: ");       
            inputString = input.nextLine(); 
 
             rec.start();     
public class list{
   public static void main(String[] arg){
      System.out.println("list reversal");
   }
}