#include "timed_execution/basic_job_interface.as"

funcdef void ON_RAGDOLL_CALLBACK(MovementObject@);

class OnRagdollJob : BasicJobInterface {
    protected int id;
    protected ON_RAGDOLL_CALLBACK @callback;
    protected float started = 0.0f;

    OnRagdollJob(){}

    OnRagdollJob(int _id, ON_RAGDOLL_CALLBACK @_callback){
        id = _id;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        if(!MovementObjectExists(id)){
            return;
        }
        MovementObject @char = ReadCharacterID(id);

        callback(char);
    }

    bool IsExpired(){
        if(!MovementObjectExists(id)){
            return false;
        }
        MovementObject @char = ReadCharacterID(id);

        return char.GetIntVar("state") == 4;
    }

    bool IsRepeating(){
        return true;
    }
}