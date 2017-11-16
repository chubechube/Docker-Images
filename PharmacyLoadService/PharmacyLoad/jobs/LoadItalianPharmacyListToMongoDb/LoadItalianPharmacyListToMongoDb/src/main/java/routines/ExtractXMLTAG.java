package routines;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ExtractXMLTAG {

    /**
     * 
     * 
     * 
     * {talendTypes} String
     * 
     * {Category} User Defined
     * 
     * {param} string("world") input: The string need to be printed.
     * 
     * {example} helloExemple("world") # hello world !.
     */
    public static String extractProductDefinition(String message,String field) {
    	String regexField ="<"+field+">(.+?)<\\/"+field+">";
    	Pattern patternField = Pattern.compile(regexField);
    	Matcher matcherField = patternField.matcher(message);
    	
    	String tempString = "";


     	if(message.equalsIgnoreCase("empty")){
     	    
     		tempString = "";
     	    }else{
    	

     	    	while (matcherField.find()) {
     	    	    tempString = tempString + matcherField.group(1);
     	    	}	
     	    }
    	
     	//System.out.println("tempString " + tempString);
        return tempString;
    }
}
