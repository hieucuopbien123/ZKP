#include <stdio.h>
#include <iostream>
#include <assert.h>
#include "circom.hpp"
#include "calcwit.hpp"
void MultiMux3_0_create(uint soffset,uint coffset,Circom_CalcWit* ctx,std::string componentName,uint componentFather);
void MultiMux3_0_run(uint ctx_index,Circom_CalcWit* ctx);
void test_1_create(uint soffset,uint coffset,Circom_CalcWit* ctx,std::string componentName,uint componentFather);
void test_1_run(uint ctx_index,Circom_CalcWit* ctx);
Circom_TemplateFunction _functionTable[2] = { 
MultiMux3_0_run,
test_1_run };
Circom_TemplateFunction _functionTableParallel[2] = { 
NULL,
NULL };
uint get_main_input_signal_start() {return 2;}

uint get_main_input_signal_no() {return 0;}

uint get_total_signal_no() {return 23;}

uint get_number_of_components() {return 2;}

uint get_size_of_input_hashmap() {return 256;}

uint get_size_of_witness() {return 2;}

uint get_size_of_constants() {return 9;}

uint get_size_of_io_map() {return 0;}

void release_memory_component(Circom_CalcWit* ctx, uint pos) {{

if (pos != 0){{

if(ctx->componentMemory[pos].subcomponents)
delete []ctx->componentMemory[pos].subcomponents;

if(ctx->componentMemory[pos].subcomponentsParallel)
delete []ctx->componentMemory[pos].subcomponentsParallel;

if(ctx->componentMemory[pos].outputIsSet)
delete []ctx->componentMemory[pos].outputIsSet;

if(ctx->componentMemory[pos].mutexes)
delete []ctx->componentMemory[pos].mutexes;

if(ctx->componentMemory[pos].cvs)
delete []ctx->componentMemory[pos].cvs;

if(ctx->componentMemory[pos].sbct)
delete []ctx->componentMemory[pos].sbct;

}}


}}


// function declarations
// template declarations
void MultiMux3_0_create(uint soffset,uint coffset,Circom_CalcWit* ctx,std::string componentName,uint componentFather){
ctx->componentMemory[coffset].templateId = 0;
ctx->componentMemory[coffset].templateName = "MultiMux3";
ctx->componentMemory[coffset].signalStart = soffset;
ctx->componentMemory[coffset].inputCounter = 11;
ctx->componentMemory[coffset].componentName = componentName;
ctx->componentMemory[coffset].idFather = componentFather;
ctx->componentMemory[coffset].subcomponents = new uint[0];
}

void MultiMux3_0_run(uint ctx_index,Circom_CalcWit* ctx){
FrElement* signalValues = ctx->signalValues;
u64 mySignalStart = ctx->componentMemory[ctx_index].signalStart;
std::string myTemplateName = ctx->componentMemory[ctx_index].templateName;
std::string myComponentName = ctx->componentMemory[ctx_index].componentName;
u64 myFather = ctx->componentMemory[ctx_index].idFather;
u64 myId = ctx_index;
u32* mySubcomponents = ctx->componentMemory[ctx_index].subcomponents;
bool* mySubcomponentsParallel = ctx->componentMemory[ctx_index].subcomponentsParallel;
FrElement* circuitConstants = ctx->circuitConstants;
std::string* listOfTemplateMessages = ctx->listOfTemplateMessages;
FrElement expaux[10];
FrElement lvar[2];
uint sub_component_aux;
uint index_multiple_eq;
{
PFrElement aux_dest = &lvar[0];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[0]);
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 20];
// load src
Fr_mul(&expaux[0],&signalValues[mySignalStart + 10],&signalValues[mySignalStart + 9]); // line circom 38
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &lvar[1];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
Fr_lt(&expaux[0],&lvar[1],&circuitConstants[0]); // line circom 40
while(Fr_isTrue(&expaux[0])){
{
PFrElement aux_dest = &signalValues[mySignalStart + 12];
// load src
Fr_sub(&expaux[7],&signalValues[mySignalStart + 8],&signalValues[mySignalStart + 7]); // line circom 42
Fr_sub(&expaux[6],&expaux[7],&signalValues[mySignalStart + 6]); // line circom 42
Fr_add(&expaux[5],&expaux[6],&signalValues[mySignalStart + 5]); // line circom 42
Fr_sub(&expaux[4],&expaux[5],&signalValues[mySignalStart + 4]); // line circom 42
Fr_add(&expaux[3],&expaux[4],&signalValues[mySignalStart + 3]); // line circom 42
Fr_add(&expaux[2],&expaux[3],&signalValues[mySignalStart + 2]); // line circom 42
Fr_sub(&expaux[1],&expaux[2],&signalValues[mySignalStart + 1]); // line circom 42
Fr_mul(&expaux[0],&expaux[1],&signalValues[mySignalStart + 20]); // line circom 42
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 13];
// load src
Fr_sub(&expaux[3],&signalValues[mySignalStart + 7],&signalValues[mySignalStart + 5]); // line circom 43
Fr_sub(&expaux[2],&expaux[3],&signalValues[mySignalStart + 3]); // line circom 43
Fr_add(&expaux[1],&expaux[2],&signalValues[mySignalStart + 1]); // line circom 43
Fr_mul(&expaux[0],&expaux[1],&signalValues[mySignalStart + 10]); // line circom 43
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 14];
// load src
Fr_sub(&expaux[3],&signalValues[mySignalStart + 6],&signalValues[mySignalStart + 5]); // line circom 44
Fr_sub(&expaux[2],&expaux[3],&signalValues[mySignalStart + 2]); // line circom 44
Fr_add(&expaux[1],&expaux[2],&signalValues[mySignalStart + 1]); // line circom 44
Fr_mul(&expaux[0],&expaux[1],&signalValues[mySignalStart + 9]); // line circom 44
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 15];
// load src
Fr_sub(&expaux[0],&signalValues[mySignalStart + 5],&signalValues[mySignalStart + 1]); // line circom 45
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 16];
// load src
Fr_sub(&expaux[3],&signalValues[mySignalStart + 4],&signalValues[mySignalStart + 3]); // line circom 47
Fr_sub(&expaux[2],&expaux[3],&signalValues[mySignalStart + 2]); // line circom 47
Fr_add(&expaux[1],&expaux[2],&signalValues[mySignalStart + 1]); // line circom 47
Fr_mul(&expaux[0],&expaux[1],&signalValues[mySignalStart + 20]); // line circom 47
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 17];
// load src
Fr_sub(&expaux[1],&signalValues[mySignalStart + 3],&signalValues[mySignalStart + 1]); // line circom 48
Fr_mul(&expaux[0],&expaux[1],&signalValues[mySignalStart + 10]); // line circom 48
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 18];
// load src
Fr_sub(&expaux[1],&signalValues[mySignalStart + 2],&signalValues[mySignalStart + 1]); // line circom 49
Fr_mul(&expaux[0],&expaux[1],&signalValues[mySignalStart + 9]); // line circom 49
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 19];
// load src
// end load src
Fr_copy(aux_dest,&signalValues[mySignalStart + 1]);
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 0];
// load src
Fr_add(&expaux[4],&signalValues[mySignalStart + 12],&signalValues[mySignalStart + 13]); // line circom 52
Fr_add(&expaux[3],&expaux[4],&signalValues[mySignalStart + 14]); // line circom 52
Fr_add(&expaux[2],&expaux[3],&signalValues[mySignalStart + 15]); // line circom 52
Fr_mul(&expaux[1],&expaux[2],&signalValues[mySignalStart + 11]); // line circom 52
Fr_add(&expaux[4],&signalValues[mySignalStart + 16],&signalValues[mySignalStart + 17]); // line circom 53
Fr_add(&expaux[3],&expaux[4],&signalValues[mySignalStart + 18]); // line circom 53
Fr_add(&expaux[2],&expaux[3],&signalValues[mySignalStart + 19]); // line circom 53
Fr_add(&expaux[0],&expaux[1],&expaux[2]); // line circom 52
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
{
PFrElement aux_dest = &lvar[1];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[0]);
}
Fr_lt(&expaux[0],&lvar[1],&circuitConstants[0]); // line circom 40
}
for (uint i = 0; i < 0; i++){
uint index_subc = ctx->componentMemory[ctx_index].subcomponents[i];
if (index_subc != 0)release_memory_component(ctx,index_subc);
}
}

void test_1_create(uint soffset,uint coffset,Circom_CalcWit* ctx,std::string componentName,uint componentFather){
ctx->componentMemory[coffset].templateId = 1;
ctx->componentMemory[coffset].templateName = "test";
ctx->componentMemory[coffset].signalStart = soffset;
ctx->componentMemory[coffset].inputCounter = 0;
ctx->componentMemory[coffset].componentName = componentName;
ctx->componentMemory[coffset].idFather = componentFather;
ctx->componentMemory[coffset].subcomponents = new uint[1]{0};
test_1_run(coffset,ctx);
}

void test_1_run(uint ctx_index,Circom_CalcWit* ctx){
FrElement* signalValues = ctx->signalValues;
u64 mySignalStart = ctx->componentMemory[ctx_index].signalStart;
std::string myTemplateName = ctx->componentMemory[ctx_index].templateName;
std::string myComponentName = ctx->componentMemory[ctx_index].componentName;
u64 myFather = ctx->componentMemory[ctx_index].idFather;
u64 myId = ctx_index;
u32* mySubcomponents = ctx->componentMemory[ctx_index].subcomponents;
bool* mySubcomponentsParallel = ctx->componentMemory[ctx_index].subcomponentsParallel;
FrElement* circuitConstants = ctx->circuitConstants;
std::string* listOfTemplateMessages = ctx->listOfTemplateMessages;
FrElement expaux[3];
FrElement lvar[1];
uint sub_component_aux;
uint index_multiple_eq;
{
uint aux_create = 0;
int aux_cmp_num = 0+ctx_index+1;
uint csoffset = mySignalStart+1;
for (uint i = 0; i < 1; i++) {
std::string new_cmp_name = "testComp";
MultiMux3_0_create(csoffset,aux_cmp_num,ctx,new_cmp_name,myId);
mySubcomponents[aux_create+i] = aux_cmp_num;
csoffset += 21 ;
aux_cmp_num += 1;
}
}
{
uint cmp_index_ref = 0;
{
PFrElement aux_dest = &ctx->signalValues[ctx->componentMemory[mySubcomponents[cmp_index_ref]].signalStart + 9];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[0]);
}
// run sub component if needed
if(!(ctx->componentMemory[mySubcomponents[cmp_index_ref]].inputCounter -= 1)){
MultiMux3_0_run(mySubcomponents[cmp_index_ref],ctx);

}
}
{
uint cmp_index_ref = 0;
{
PFrElement aux_dest = &ctx->signalValues[ctx->componentMemory[mySubcomponents[cmp_index_ref]].signalStart + 10];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[7]);
}
// run sub component if needed
if(!(ctx->componentMemory[mySubcomponents[cmp_index_ref]].inputCounter -= 1)){
MultiMux3_0_run(mySubcomponents[cmp_index_ref],ctx);

}
}
{
uint cmp_index_ref = 0;
{
PFrElement aux_dest = &ctx->signalValues[ctx->componentMemory[mySubcomponents[cmp_index_ref]].signalStart + 11];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[6]);
}
// run sub component if needed
if(!(ctx->componentMemory[mySubcomponents[cmp_index_ref]].inputCounter -= 1)){
MultiMux3_0_run(mySubcomponents[cmp_index_ref],ctx);

}
}
{
PFrElement aux_dest = &lvar[0];
// load src
// end load src
Fr_copy(aux_dest,&circuitConstants[1]);
}
Fr_lt(&expaux[0],&lvar[0],&circuitConstants[8]); // line circom 10
while(Fr_isTrue(&expaux[0])){
{
uint cmp_index_ref = 0;
{
PFrElement aux_dest = &ctx->signalValues[ctx->componentMemory[mySubcomponents[cmp_index_ref]].signalStart + ((0 + (1 * Fr_toInt(&lvar[0]))) + 1)];
// load src
// end load src
Fr_copy(aux_dest,&lvar[0]);
}
// run sub component if needed
if(!(ctx->componentMemory[mySubcomponents[cmp_index_ref]].inputCounter -= 1)){
MultiMux3_0_run(mySubcomponents[cmp_index_ref],ctx);

}
}
{
PFrElement aux_dest = &lvar[0];
// load src
Fr_add(&expaux[0],&lvar[0],&circuitConstants[0]); // line circom 10
// end load src
Fr_copy(aux_dest,&expaux[0]);
}
Fr_lt(&expaux[0],&lvar[0],&circuitConstants[8]); // line circom 10
}
{
PFrElement aux_dest = &signalValues[mySignalStart + 0];
// load src
// end load src
Fr_copy(aux_dest,&ctx->signalValues[ctx->componentMemory[mySubcomponents[0]].signalStart + 0]);
}
for (uint i = 0; i < 1; i++){
uint index_subc = ctx->componentMemory[ctx_index].subcomponents[i];
if (index_subc != 0)release_memory_component(ctx,index_subc);
}
}

void run(Circom_CalcWit* ctx){
test_1_create(1,0,ctx,"main",0);
test_1_run(0,ctx);
}

