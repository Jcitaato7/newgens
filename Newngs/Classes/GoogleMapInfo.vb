Public Class GoogleMapInfo
    Private m_DealerRowID As Integer
    Private m_DealerName As String
    Private m_DealerLat As Decimal
    Private m_DealerLong As Decimal
    Private m_DealerAddr As String
    Private m_DealerWebLink As String
    Private m_DealerEmail As String
    Public Property DealerRowID() As Integer
        Get
            Return m_DealerRowID
        End Get
        Set(value As Integer)
            m_DealerRowID = value
        End Set
    End Property
    Public Property DealerName() As String
        Get
            Return m_DealerName
        End Get
        Set(value As String)
            m_DealerName = value
        End Set
    End Property
    Public Property DealerLat() As Decimal
        Get
            Return m_DealerLat
        End Get
        Set(value As Decimal)
            m_DealerLat = value
        End Set
    End Property
    Public Property DealerLong() As Decimal
        Get
            Return m_DealerLong
        End Get
        Set(value As Decimal)
            m_DealerLong = value
        End Set
    End Property
    Public Property DealerAddr() As String
        Get
            Return m_DealerAddr
        End Get
        Set(value As String)
            m_DealerAddr = value
        End Set
    End Property
    Public Property DealerWebLink() As String
        Get
            Return m_DealerWebLink
        End Get
        Set(value As String)
            m_DealerWebLink = value
        End Set
    End Property
    Public Property DealerEmail() As String
        Get
            Return m_DealerEmail
        End Get
        Set(value As String)
            m_DealerEmail = value
        End Set
    End Property
End Class
