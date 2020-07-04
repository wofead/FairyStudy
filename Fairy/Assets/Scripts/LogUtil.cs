using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace FairyStudy
{
    public static class LogUtil
    {
        static bool isDebug = true;
        static string userName = "unKnow";

        static LogUtil()
        {
            Application.logMessageReceived += (msg, stack, type) =>
            {
                switch (type)
                {
                    case LogType.Warning:
                        LogToFile(msg + "\n", true);
                        break;
                    case LogType.Log:
                        LogToFile(msg + "\n", true);
                        break;
                    case LogType.Error:
                    case LogType.Assert:
                    case LogType.Exception:
                        var text = string.Format("[{0}]{1}\n{2}", DateTime.Now.ToString("HH:mm:ss.ffff"), msg, stack);
                        LogToFile(text, true);
                        //LogUtil.MessageBox(text, "Error");
                        break;
                    default:
                        break;
                }
            };
        }

        public static void SetUserName(string name)
        {
            userName = name;
        }

        public static void SetDebug(bool value)
        {
            isDebug = value;
        }

        public static void InfoColor(string color, string log, params object[] args)
        {
            DoLog(log, args, LogType.Log, color);
        }

        public static void Info(string log, params object[] args)
        {
            DoLog(log, args, LogType.Log);
        }

        public static void Error(string log, params object[] args)
        {
            DoLog(log, args, LogType.Error);
        }

        public static void Warning(string log, params object[] args)
        {
            DoLog(log, args, LogType.Warning);
        }

        public static void Assert(bool isSuccess, string log, params object[] args)
        {
            if (isSuccess == false)
            {
                DoLog(log, args, LogType.Assert);
            }
        }
        public static void DoLog(string msg, object[] args, LogType level, string color = "")
        {
            if (!isDebug)
            {
                return;
            }
            if (args.Length > 0)
            {
                msg = string.Format(msg, args);
            }
            if (color != "")
            {
                int firstLine = msg.IndexOf('\n');
                if (firstLine == -1)
                {
                    msg = string.Format("<color={0}>[{1}]{2}</color>\n", color, DateTime.Now.ToString("HH:mm:ss.ffff"), msg);
                }
                else
                {
                    msg = string.Format("<color={0}>[{1}]{2}</color>\n\n<color={3}>{4}</color>", color, DateTime.Now.ToString("HH:mm:ss.ffff"), msg.Substring(0, firstLine), color, msg.Substring(firstLine + 1));
                }
            }
            else
            {
                msg = string.Format("[{0}]{1}\n", DateTime.Now.ToString("HH:mm:ss.ffff"), msg);
            }
            switch(level)
            {
                case LogType.Warning:
                    Debug.LogWarning(msg);
                    break;
                case LogType.Error:
                    Debug.LogError(msg);
                    break;
                case LogType.Assert:
                    Debug.Assert(false, msg);
                    break;
                case LogType.Log:
                    Debug.Log(msg);
                    break;
                default:
                    break;
            }
        }

        public static void LogToFile(string msg, bool append, string filename = "")
        {
            string fullPath = GetLogPath(filename);
            string dir = Path.GetDirectoryName(fullPath);
            if (!Directory.Exists(dir))
                Directory.CreateDirectory(dir);
            if (!append)
            {
                File.Delete(fullPath);
                //File.WriteAllText(fullPath, "");
            }

            using (
                FileStream fileStream = new FileStream(fullPath, append ? FileMode.Append : FileMode.Create,
                    FileAccess.Write, FileShare.ReadWrite)) // 不会锁死, 允许其它程序打开
            {
                lock (fileStream)
                {
                    StreamWriter writer = new StreamWriter(fileStream);
                    writer.Write(msg);
                    writer.Flush();
                    writer.Close();
                }
            }
        }

        public static string GetLogPath(string fileName)
        {
            string logPath;
            if (Application.isEditor || Application.platform == RuntimePlatform.OSXPlayer || Application.platform == RuntimePlatform.WindowsPlayer)
                logPath = AppConfig.Instance.assetsExportPath + "/Logs/";
            else
                logPath = Path.Combine(Application.persistentDataPath, "Logs/");
            string logName = string.Format("log_{0}.log", userName);
            if (fileName != "")
            {
                logName = string.Format("log_{0}.log", fileName);
            }
            return logPath + logName;
        }
    }
}

