
--START:Avanti:3 March 2022: Chnages for OPD Examination page---
--Add Columns in vitals for Ayurved
ALTER TABLE  CLN_PatientVitals
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


--START:NageshBB: 03 March 2022: new changes for build
Update CFG_PrinterSettings
set PrinterDisplayName=GroupName+'-Browser-Printer'
where PrintingType='browser'
Go
Update CFG_PrinterSettings
set IsActive=0 where PrintingType='dotmatrix'
go
--END:NageshBB: 03 March 2022: new changes for build

--START: Menka/Nagesh: 03-03-2022: Create table for OPPatients which used for OPDataLoad project
DROP TABLE IF EXISTS [dbo].[OPPatients];
Go
Create table [dbo].[OPPatients](
	[OPPatientId] [int] IDENTITY(1,1) NOT NULL CONSTRAINT PK_OPPatients PRIMARY KEY,
	[FirstName] [varchar](50) NULL,
	[MiddleName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[DateOfBirth] [datetime] NULL,
	[Age] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[VillageCity] [varchar](50) NULL,
	[Taluka] [varchar](50) NULL,
	[District] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
	[IsActive] [bit] default 1,
	[IsEMRPatient] [bit] default 0
	);
GO
--END: Menka/Nagesh: 03-03-2022: Create table for OPPatients which used for OPDataLoad project
