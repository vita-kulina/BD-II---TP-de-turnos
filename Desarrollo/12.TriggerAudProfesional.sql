create trigger AudProfesional
on Profesional
for insert, update, delete
as
declare @numIns int
declare @numDel int
set @numIns=(select count (*) from inserted)
set @numDel=(select count (*) from deleted)
if @numIns<>0 and @numIns=@numDel
	begin 
		insert into Auditoria (usuario, fecha, accion, tabla)
		values (current_user, getdate(), 'Update', 'Profesional')
	end
else if @numIns>0 and @numDel=0
	begin 
		insert into Auditoria (usuario, fecha, accion, tabla)
		values (current_user, getdate(), 'Insert', 'Profesional')
	end	
else if @numDel>0 and @numIns=0
	begin 
		insert into Auditoria (usuario, fecha, accion, tabla)
		values (current_user, getdate(), 'Delete', 'Profesional')
	end	