#include "timed_execution/timed_execution.as"
#include "bouncy/timed_execution/on_ragdoll_job.as"

TimedExecution timer;

float push_force_mult = 1000.0f;

void Init(string level_name){
    int num = GetNumCharacters();
    for(int i = 0; i < num; ++i){
        MovementObject@ char = ReadCharacter(i);
        timer.Add(OnRagdollJob(char.GetID(), function(_char){
            RiggedObject@ rig = _char.rigged_object();
            _char.Execute("recovery_time = 1.0f;");

            if(length(rig.GetAvgVelocity()) < 5.0f){
                vec3 direction = vec3(rand()%5-2, rand()%4-1, rand()%5-2) * push_force_mult;
                rig.ApplyForceToRagdoll(direction, rig.skeleton().GetCenterOfMass());
            }
        }));
    }    
}

void ReceiveMessage(string msg){
    timer.AddLevelEvent(msg);
}

void Update(){
    timer.Update();
}

bool HasFocus(){
    return false;
}

void DrawGUI(){}

void Menu(){
    ImGui_SliderFloat("Ragdoll Force", push_force_mult, 0, 10000);
}
