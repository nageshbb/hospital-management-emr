
--START:Avanti:3 March 2022: Chnages for OPD Examination page---
--Add Columns in vitals for Ayurved
ALTER TABLE CLN_PatientVitals
ADD Nadi    int,
    Mala    varchar(20),
    Mutra   varchar(20),
    Jivha   varchar(20),
    Shabda  varchar(20),
    Sparsha varchar(20),
    Drik    varchar(20),
    Akriti  varchar(20),
    LungField varchar(20),
    HeartSounds nvarchar(20),
    PA_Tenderness varchar(20),
    Organomegaly varchar(20),
    CNS_Consiousness varchar(20),
    Power varchar(20),
    Reflexes varchar(20),
    Tone varchar(20),
    Others varchar(50)
Go


--insert routing for opd examination
Insert Into RBAC_RouteConfig (DisplayName,UrlFullPath,RouterLink,PermissionId,ParentRouteId,IsActive)
Values ('OPD Examination','Doctors/PatientOverviewMain/NotesSummary/OPDExamination','OPDExamination',(Select PermissionId from RBAC_Permission where PermissionName = 'Clinical-notes-outpatExamination-view'),3,1)
GO

Insert Into CLN_Template (TemplateName,CreatedBy,CreatedOn,IsActive,IsForNursing)
Values ('OPD Examination',1,GETDATE(),1,1)
GO

Insert Into CLN_MST_NoteType(NoteType,CreatedBy,CreatedOn,IsActive,IsForNursing)
Values('OPD Examination',1,GETDATE(),1,1)
GO

--create Core parameter for get noteType
IF Not EXISTS (SELECT  * FROM  CORE_CFG_Parameters WHERE ParameterGroupName='Clinical'  and ParameterName='DefaultNotesType_OPDExamination')
Begin
Insert Into CORE_CFG_Parameters(ParameterGroupName,ParameterName,ParameterValue,ValueDataType,Description,ParameterType)
Values('Clinical','DefaultNotesType_OPDExamination','OPD Examination','string','This notes name we are using for get notesId (from CLN_MST_NoteType,) and save in CLN_Notes table for OPD Examination','custom')
End
Else
Begin
     update [dbo].[CORE_CFG_Parameters] 
	 set [ParameterValue]='OPD Examination'
	 where [ParameterGroupName]='Clinical' and [ParameterName]='DefaultNotesType_OPDExamination'     
End
GO
--END:Avanti:3 March 2022: Chnages for OPD Examination page---