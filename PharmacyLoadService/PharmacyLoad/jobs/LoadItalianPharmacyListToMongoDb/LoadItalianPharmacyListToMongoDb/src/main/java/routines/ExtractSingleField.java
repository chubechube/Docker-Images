package routines;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/*
 * user specification: the function's comment should contain keys as follows: 1. write about the function's comment.but
 * it must be before the "{talendTypes}" key.
 * 
 * 2. {talendTypes} 's value must be talend Type, it is required . its value should be one of: String, char | Character,
 * long | Long, int | Integer, boolean | Boolean, byte | Byte, Date, double | Double, float | Float, Object, short |
 * Short
 * 
 * 3. {Category} define a category for the Function. it is required. its value is user-defined .
 * 
 * 4. {param} 's format is: {param} <type>[(<default value or closed list values>)] <name>[ : <comment>]
 * 
 * <type> 's value should be one of: string, int, list, double, object, boolean, long, char, date. <name>'s value is the
 * Function's parameter name. the {param} is optional. so if you the Function without the parameters. the {param} don't
 * added. you can have many parameters for the Function.
 * 
 * 5. {example} gives a example for the Function. it is optional.
 */
public class ExtractSingleField {

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
    	
    	final String regexFDI_001 = "<FDI_0001>(.+?)<\\/FDI_0001>";	
    	final String regexFDI_004 = "<FDI_0004>(.+?)<\\/FDI_0004>";	
    	final Pattern patternFDI_001 = Pattern.compile(regexFDI_001);
    	final Pattern patternFDI_004 = Pattern.compile(regexFDI_004);
    	final Matcher matcherFDI_001 = patternFDI_001.matcher(message);
    	final Matcher matcherFDI_004 = patternFDI_004.matcher(message);
    	String tempString = "";


     	if(message.equalsIgnoreCase("empty")){
     	    
     		tempString = "Empty";
     	    }else{
    	

     	    	while (matcherField.find()) {
     	    	    tempString = tempString + matcherField.group(1);
     	    	}	
     	    }
    	
     	//System.out.println("tempString " + tempString);
        return tempString;
    }
}
