Public Class DistrictInfo
    Private m_DistrictName As String
    Private m_DistrictID As Integer
    Public Property DistrictName() As String
        Get
            Return m_DistrictName
        End Get
        Set(value As String)
            m_DistrictName = value
        End Set
    End Property
    Public Property DistrictID() As Integer
        Get
            Return m_DistrictID
        End Get
        Set(value As Integer)
            m_DistrictID = value
        End Set
    End Property
End Class
