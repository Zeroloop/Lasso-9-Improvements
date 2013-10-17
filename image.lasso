<?lassoscript

define image->ishex(hex::string,units::integer=8) => {
    //  Example usage: 
    //  image('myimage.jpg')->ishex('#FF0000') ? fail(-1,'Red is not welcome here')
 
    local(
        x = .width / #units,
        y = .height / #units,
        i = 0
    )
     
    while(#i < #units) => {
        .pixel(#i * #x,#i * #y,-hex)->asstring != #hex ? return false
        .pixel((#units - #i) * #x -1,(#units - #i) * #y -1,-hex)->asstring != #hex ? return false
        #i++
    }
 
    return true 
}
 
define image->isblack => .ishex('#000000')    
define image->iswhite => .ishex('#FFFFFF')

?>