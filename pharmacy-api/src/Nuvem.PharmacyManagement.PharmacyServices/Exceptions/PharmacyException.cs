namespace Nuvem.PharmacyManagement.PharmacyServices.Exceptions;
public abstract class PharmacyException : Exception
{
    public PharmacyException(string message) : base(message)
    {        
    }
}

public class NotFoundException : PharmacyException
{
    public NotFoundException(string message) : base(message)
    {
    }
}

public class BadRequestException : PharmacyException
{
    public BadRequestException(string message) : base(message)
    {
    }
}

