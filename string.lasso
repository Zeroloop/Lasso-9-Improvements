<?lassoscript
/*

Example:

	'Brand™ with some other random® characters.'->ascii

Result: 
	
	Brand with some other random characters.

*/

define string->ascii => bytes->importstring(self,'ASCII') & asstring

?>