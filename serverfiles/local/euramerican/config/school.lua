
--[npc 类型ID] = {声望Id, 1点师道值换取的声望值}
TeacherPointToCredit = {
    [406] = {CreditId = 14, PerTeacherPointToCredit = 100},
    [407] = {CreditId = 17, PerTeacherPointToCredit = 100},
    [413] = {CreditId = 15, PerTeacherPointToCredit = 100},
    [414] = {CreditId = 16, PerTeacherPointToCredit = 100},
    [4865] = {CreditId = 29, PerTeacherPointToCredit = 100},
    [4101] = {CreditId = 26, PerTeacherPointToCredit = 100},
    [4201] = {CreditId = 22, PerTeacherPointToCredit = 100},
    [4512] = {CreditId = 13, PerTeacherPointToCredit = 100},
    [4650] = {CreditId = 28, PerTeacherPointToCredit = 100},
    [4651] = {CreditId = 30, PerTeacherPointToCredit = 100},
    [4415] = {CreditId = 31, PerTeacherPointToCredit = 100},
    [4864] = {CreditId = 33, PerTeacherPointToCredit = 10},
}

function OnStudentLevelUp(nStudentId, nLevel, nState) --学徒升级
     iParty=GetUserParty(nStudentId)
     if nLevel == 10 then
       if iParty == 0 then
         CreateItemAndMail(nStudentId, 5, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 15, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 1 then
	 CreateItemAndMail(nStudentId, 25, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 35, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 2 then
	 CreateItemAndMail(nStudentId, 551, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 561, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 3 then
	 CreateItemAndMail(nStudentId, 55, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 45, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 4 then
	 CreateItemAndMail(nStudentId, 629, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 639, "blue", "binded", 0, 0, 0, 156)
       end
    elseif nLevel == 20 then
       CreateItemAndMailToTeacher(3970, "white", "binded", 0, 0, 0, 0)
       if iParty == 0 then
         CreateItemAndMail(nStudentId, 6, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 16, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 1 then
	 CreateItemAndMail(nStudentId, 26, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 36, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 2 then
	 CreateItemAndMail(nStudentId, 552, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 562, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 3 then
	 CreateItemAndMail(nStudentId, 56, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 46, "blue", "binded", 0, 0, 0, 156)
       elseif iParty == 4 then
	 CreateItemAndMail(nStudentId, 630, "blue", "binded", 0, 0, 0, 156)
	 CreateItemAndMail(nStudentId, 640, "blue", "binded", 0, 0, 0, 156)
       end
   elseif nLevel == 30 then
       CreateItemAndMailToTeacher(3971, "white", "binded", 0, 0, 0, 0)
   elseif nLevel == 40 then
       CreateItemAndMail(nStudentId, 3971, "white", "binded", 0, 0, 0, 0)
       CreateItemAndMail(nStudentId, 3971, "white", "binded", 0, 0, 0, 0)
       CreateItemAndMailToTeacher(382, "white", "binded", 0, 0, 0, 0)
       CreateItemAndMailToTeacher(382, "white", "binded", 0, 0, 0, 0)
       CreateItemAndMailToTeacher(402, "white", "binded", 0, 0, 0, 0)
   end
end