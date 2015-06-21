/*
	Author: Michał Tuśnio

	Description:
	Executed locally, removes all tasks assigned to player

	Parameter(s):
	None

	Returns:
	Removed taskIds
*/

if(!isDedicated) then
{
    private["_tasks"];
    _tasks = simpleTasks player;
    
    {
        player removeSimpleTask _x;
    } forEach _tasks;
    
    _tasks;
}
else
{
    [];
};
