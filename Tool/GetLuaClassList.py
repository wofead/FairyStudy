#! python3
import os,sys

root_path = os.path.dirname(os.path.dirname(os.path.realpath(sys.argv[0])))
root_path = os.path.join(root_path, "./Lua/Src")
print(root_path)
checkDir = {}

datatableExtension = {}

content = '''
-------------------------------------------------------------------------------
--
-- 这个文件是所有的功能模块对应的lua文件列表 
-- 由工具自动生成,请勿手工修改
--
--------------------------------------------------------------------------------
---@class LuaClassList
LuaClassList = 
{
'''
isSuccess = True
fileCounts = 0
for parent, dirs, files in os.walk(root_path):
	for file in files:
		split = os.path.splitext(file)
		extension = split[1].lower()
		if extension == ".lua":
			filename = split[0].lower()
			if filename.rfind("datatableextension") != -1:
				datatableExtension[filename] = filename

			relative = os.path.join(parent, file)[len(root_path) + 1:-4]
			relative = relative.replace("\\", ".")
			checkSplit = relative.split(".")
			if relative.rfind("cocos") == -1 and relative.rfind("net.protobuf") == -1 and checkSplit[len(checkSplit) - 1].islower():
				print("ERROR: Lua类型首字母必须大写 {0}.lua".format(relative))
				isSuccess = False
			if filename in checkDir:
				print("ERROR: 不能定义两个同名文件\n{0}.lua\n{1}.lua\n".format(checkDir[filename], relative))
				isSuccess = False
			checkDir[filename] = relative
			fileCounts = fileCounts + 1
			content = "{}\t{: <40}= \"{}\",\n".format(content, filename, relative)

if isSuccess == False:
	input("任意键退出...")
	sys.exit()

content = content + "\n}\n\n"

content = content + "DatatableExtension = \n"
content = content + "{\n"
for x in datatableExtension:
	content = content + "    " + x + " = LuaClassList." + x + ",\n"

content = content + "\n}\n\n"

classContent = "---@class LuaClass"
# isSuccess = True
# fileCounts = 0
for parent, dirs, files in os.walk(root_path):
	for file in files:
		split = os.path.splitext(file)
		extension = split[1].lower()
		if extension == ".lua":
			filename = split[0]
			relative = os.path.join(parent, file)[len(root_path) + 1:-4]
			relative = relative.replace("\\", ".")
			checkSplit = relative.split(".")
			# if relative.rfind("cocos") == -1 and checkSplit[len(checkSplit) - 1].islower():
			# 	print("ERROR: Lua类型首字母必须大写 {0}.lua".format(relative))
			# 	isSuccess = False
			# if filename in checkDir:
			# 	print("ERROR: 不能定义两个同名文件\n{0}.lua\n{1}.lua\n".format(checkDir[filename], relative))
			# 	isSuccess = False
			checkDir[filename] = relative
			# fileCounts = fileCounts + 1
			classContent = classContent + "\n---@field {}  {}   ".format(filename, filename)
			#classContent = "{}    ---@type {}\n\t{: <40}= {},\n".format(classContent, filename, filename, "nil")

# if isSuccess == False:
# 	input("任意键退出...")
# 	sys.exit()

classContent = classContent + "\nlocal LuaClass = {}"

content = content + "\n"
content = content + "LuaClass = {}"


filepath = os.path.join(root_path, "Core/LuaClassList.lua")

file = open(filepath, "w", encoding='UTF-8')
file.write(content)
file.close()

filepath = os.path.join(root_path, "Core/LuaClassTips.lua")
file = open(filepath, "w", encoding='UTF-8')
file.write(classContent)
file.close()

print("操作完成，共计{0}个文件\n".format(fileCounts))
input("任意键退出...")