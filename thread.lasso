<?lassoscript
/*

Description:

Restricts code from executing more frequently than the specified number of seconds. Returns the number of seconds to wait until blocks should be executed.

Example:

		define my_thread => thread {
		   public active_tick => every(60) => {
			  // do stuff
		   }
		}

*/

define every(seconds::integer) => {
    local(
        gb =  givenblock,
        v = '_poll_'+#gb->self->type + #gb->methodname,
        last = var(#v),
        since = #last ? #last->secondsBetween(date) | #seconds
    )   
    if(#since >= #seconds) => {
        handle => { var(#v) = date }
        return #gb() || #seconds
    else
        return (#seconds - #since)
    }
}

?>