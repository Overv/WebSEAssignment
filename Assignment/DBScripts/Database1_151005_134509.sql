-- Group [Group]
create table "public"."group" (
   "oid"  int4  not null,
   "groupname"  varchar(255),
  primary key ("oid")
);


-- Module [Module]
create table "public"."module" (
   "oid"  int4  not null,
   "moduleid"  varchar(255),
   "modulename"  varchar(255),
  primary key ("oid")
);


-- User [User]
create table "public"."user" (
   "oid"  int4  not null,
   "username"  varchar(255),
   "password"  varchar(255),
   "email"  varchar(255),
   "birthdate"  date,
   "name"  varchar(255),
  primary key ("oid")
);


-- Item [ent1]
create table "public"."item" (
   "oid"  int4  not null,
   "title"  varchar(255),
   "caption"  varchar(255),
   "url"  varchar(255),
  primary key ("oid")
);


-- Task [ent2]
create table "public"."task" (
   "oid"  int4  not null,
   "completed"  bool,
  primary key ("oid")
);


-- Worker [ent3]
create table "public"."worker" (
   "oid"  int4  not null,
   "accuracy"  float8,
   "piggybank"  float8,
  primary key ("oid")
);


-- Annotation [ent4]
create table "public"."annotation" (
   "oid"  int4  not null,
   "label"  varchar(255),
   "confidence"  int4,
  primary key ("oid")
);


-- AnnotationCampaign [ent5]
create table "public"."annotationcampaign" (
   "oid"  int4  not null,
   "budget"  float8,
   "status"  bool,
   "name"  varchar(255),
  primary key ("oid")
);


-- Requester [ent6]
create table "public"."requester" (
   "oid"  int4  not null,
  primary key ("oid")
);


-- Skill [ent7]
create table "public"."skill" (
   "oid"  int4  not null,
   "name"  varchar(255),
  primary key ("oid")
);


-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]
alter table "public"."group"  add column  "module_oid"  int4;
alter table "public"."group"   add constraint fk_group_module foreign key ("module_oid") references "public"."module" ("oid");


-- Group_Module [Group2Module_Module2Group]
create table "public"."group_module" (
   "group_oid"  int4 not null,
   "module_oid"  int4 not null,
  primary key ("group_oid", "module_oid")
);
alter table "public"."group_module"   add constraint fk_group_module_group foreign key ("group_oid") references "public"."group" ("oid");
alter table "public"."group_module"   add constraint fk_group_module_module foreign key ("module_oid") references "public"."module" ("oid");


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table "public"."user"  add column  "group_oid"  int4;
alter table "public"."user"   add constraint fk_user_group foreign key ("group_oid") references "public"."group" ("oid");


-- User_Group [User2Group_Group2User]
create table "public"."user_group" (
   "user_oid"  int4 not null,
   "group_oid"  int4 not null,
  primary key ("user_oid", "group_oid")
);
alter table "public"."user_group"   add constraint fk_user_group_user foreign key ("user_oid") references "public"."user" ("oid");
alter table "public"."user_group"   add constraint fk_user_group_group foreign key ("group_oid") references "public"."group" ("oid");


-- AnnotationCampaign_Requester [rel1]
alter table "public"."requester"  add column  "annotationcampaign_oid"  int4;
alter table "public"."requester"   add constraint fk_requester_annotationcampaig foreign key ("annotationcampaign_oid") references "public"."annotationcampaign" ("oid");


-- AssignedWorker [rel10]
alter table "public"."worker"  add column  "task_oid"  int4;
alter table "public"."worker"   add constraint fk_worker_task foreign key ("task_oid") references "public"."task" ("oid");


-- AnnotationCampaign_Task [rel2]
alter table "public"."annotationcampaign"  add column  "task_oid"  int4;
alter table "public"."annotationcampaign"   add constraint fk_annotationcampaign_task foreign key ("task_oid") references "public"."task" ("oid");


-- Task_Item [rel3]
create table "public"."task_item" (
   "task_oid"  int4 not null,
   "item_oid"  int4 not null,
  primary key ("task_oid", "item_oid")
);
alter table "public"."task_item"   add constraint fk_task_item_task foreign key ("task_oid") references "public"."task" ("oid");
alter table "public"."task_item"   add constraint fk_task_item_item foreign key ("item_oid") references "public"."item" ("oid");


-- User_Worker [rel4]
alter table "public"."worker"  add column  "user_oid"  int4;
alter table "public"."worker"   add constraint fk_worker_user foreign key ("user_oid") references "public"."user" ("oid");


-- PreassignedWorkers [rel5]
create table "public"."preassignedworkers" (
   "worker_oid"  int4 not null,
   "task_oid"  int4 not null,
  primary key ("worker_oid", "task_oid")
);
alter table "public"."preassignedworkers"   add constraint fk_preassignedworkers_worker foreign key ("worker_oid") references "public"."worker" ("oid");
alter table "public"."preassignedworkers"   add constraint fk_preassignedworkers_task foreign key ("task_oid") references "public"."task" ("oid");


-- Annotation_Item [rel6]
alter table "public"."item"  add column  "annotation_oid"  int4;
alter table "public"."item"   add constraint fk_item_annotation foreign key ("annotation_oid") references "public"."annotation" ("oid");


-- User_Requester [rel7]
alter table "public"."requester"  add column  "user_oid"  int4;
alter table "public"."requester"   add constraint fk_requester_user foreign key ("user_oid") references "public"."user" ("oid");


-- Skill_Worker [rel8]
create table "public"."skill_worker" (
   "skill_oid"  int4 not null,
   "worker_oid"  int4 not null,
  primary key ("skill_oid", "worker_oid")
);
alter table "public"."skill_worker"   add constraint fk_skill_worker_skill foreign key ("skill_oid") references "public"."skill" ("oid");
alter table "public"."skill_worker"   add constraint fk_skill_worker_worker foreign key ("worker_oid") references "public"."worker" ("oid");


-- Skill_Task [rel9]
create table "public"."skill_task" (
   "skill_oid"  int4 not null,
   "task_oid"  int4 not null,
  primary key ("skill_oid", "task_oid")
);
alter table "public"."skill_task"   add constraint fk_skill_task_skill foreign key ("skill_oid") references "public"."skill" ("oid");
alter table "public"."skill_task"   add constraint fk_skill_task_task foreign key ("task_oid") references "public"."task" ("oid");


