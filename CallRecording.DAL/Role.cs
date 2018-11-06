using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CallRecording.Data;

namespace CallRecording.DAL
{
    public class RoleRepository
    {
        private CallRecordingEntities callRecordingEntities;

        public RoleRepository()
        {
            callRecordingEntities = new CallRecordingEntities();
        }
        
        public List<Role> GetRoles()
        {
            var queryRoles = callRecordingEntities.Roles.ToList();
            return queryRoles;
        }
    }
}
